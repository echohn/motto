module Motto
  class Loader
    def initialize
      @categories = []
      keys.each do |key|
        @categories << Motto::Category.new(key)
      end
    end

    def categories_info
      @categories.map.with_object({}) { |x, h| h[x.key] = x.name }
    end

    def sample(key = nil)
      if key
        category = @categories.find { |x| x.key == key }
        category&.sample
      else
        @categories&.sample&.sample
      end
    end

    def keys
      path = Pathname.new MOTTOS_DIR
      # 部分 ruby 版本不支持这种 glob 写法，如 2.4.6
      # path.glob("*.yml").map { |x| x.basename.to_s.sub(x.extname, '') }
      path.children.select {|x| x.extname == '.yml'}.map { |x| x.basename.to_s.sub(x.extname, '') }
    end
  end
end
