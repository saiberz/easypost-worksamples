class Object
  def self.init(*names)
    define_method(:initialize) do |*args|
      names.zip(args).each do |name, arg|
        instance_variable_set("@#{name}", arg)
      end

      singleton_class.class_eval do
        attr_reader *names
      end
    end
  end

  def hook(name, *args, &block)
    send(name, *args, &block) if respond_to? name
  end
end

