class ParcelPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      length: @object.length,
      width: @object.width,
      height: @object.height,
      weight: @object.weight,
      predefined_package: @object.predefined_package,
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

