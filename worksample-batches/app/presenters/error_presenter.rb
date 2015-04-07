class ErrorPresenter < BasePresenter
  def initialize(object)
    @object = object
  end

  def as_json(options = {})
    {
      error: {
        code: object.code,
        message: object.message
      }
    }
  end
end

