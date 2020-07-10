module Motto
  class Category

    attr_reader :key, :name

    def initialize(key)
      @key  = key
      @file = File.join(MOTTOS_DIR, "#{@key}.yml")

      unless File.exist? @file
        raise NotFoundCategory, "NOT FOUND FILE #{@file}"
      end

      @mtime = File.mtime @file
      load_file
    end

    def mottos
      reload
      @mottos
    end

    def sample
      reload
      @mottos.sample
    end

    private

    def need_reload?
      new_mtime = File.mtime @file
      new_mtime > @mtime
    end

    def reload
      load_file if need_reload?
    end

    def load_file
      data    = YAML.load(IO.read(@file))
      @name   = data['category']
      @mottos = data['mottos']
    end

  end
end
