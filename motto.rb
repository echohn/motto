require 'yaml'

class Motto

  class MottoCategory

    MOTTOS_DIR = File.join(File.dirname(__FILE__),'mottos')

    attr_reader :category

    def initialize(category)
      @category = category

      @file =  File.join(MOTTOS_DIR,"#{@category}.yml")

      unless File.exist? @file
        raise "NOT FOUND FILE #{@file}"
      end

      @mtime = File.mtime @file
      update
    end

    def mottos
      if need_update?
        update
      end
      @mottos
    end

    private

    def need_update?
      new_mtime = File.mtime @file
      new_mtime > @mtime
    end

    def update
      @mottos = YAML.load(IO.read(@file))
    end

  end

  CATEGORIES_DETAIL = {
    'dev' => '开发类格言',
    'ops' => '运维类格言',
    'pmp' => '项目管理类格言',
    'method' => '方法论',
    'famous' => '名人名言'
  }

  def initialize
    @mottos = []
    categories.each do |category|
      @mottos << MottoCategory.new(category)
    end
  end

  def categories_detail
    CATEGORIES_DETAIL
  end

  def categories
    CATEGORIES_DETAIL.keys
  end

  def sample(category = nil)
    if category
      motto_category = @mottos.find{|x| x.category == category}
      motto_category.mottos.sample
    else
      @mottos.map{|x| x.mottos }.flatten.sample
    end
  end

end
