class PostageLabelPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      shipment_id: @object.shipment.try(:public_id),
      rate_id: @object.rate.try(:public_id),
      label_url: @object.label_url,
      label_date: @object.label_date,
      label_resolution: @object.label_resolution,
      label_width: @object.label_width,
      label_height: @object.label_height,
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

