require 'yaml'

class Motto

  def initialize
    @mottos = {}
    @mottos_file_dir = File.join(File.dirname(__FILE__),'mottos')
  end

  def sample
    check_or_update_all
    @mottos.values.map{|x|x[:mottos]}.flatten.sample
  end

  def category(category)
    check_or_update(category)
    @mottos[category][:mottos].sample
  end

  def category_source_file(category)
    File.join(@mottos_file_dir,"#{category}.yml")
  end

  def categories
    Dir[File.join(@mottos_file_dir,"*.yml")].map{|x|File.basename(x,'.yml')}
  end


  def need_update?(category)
    source_file_mtime = File.mtime(category_source_file(category))
    mottos_mtime = @mottos[category][:updated_at]
    source_file_mtime > mottos_mtime
  end

  def update(category)
    source_file_mtime = File.mtime(category_source_file(category))
    mottos = YAML.load(IO.read(category_source_file(category)))
    @mottos[category] = {updated_at: source_file_mtime, mottos: mottos}
    puts "########### #{category} file updated!"
  end

  def check_or_update(category)
    if @mottos[category].nil?  or need_update?(category)
      update(category)
    end
  end

  def check_or_update_all
    categories.each do |category|
      check_or_update(category)
    end
  end

end
