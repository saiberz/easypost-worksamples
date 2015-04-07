class UserPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      name: @object.name,
      email: @object.email,
    }
  end
end

