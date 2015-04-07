class BasePresenter
  attr_reader :object

  def self.from_array(objects)
    objects.map { |o| new(o) }
  end

  def initialize(object)
    @object = object
  end

  def class_name
    @object.class.name
  end
end

