class RatePresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      shipment_id: @object.shipment.try(:public_id),
      service: @object.service,
      carrier: @object.carrier,
      rate: sprintf("%.2f", @object.rate_cents / 100),
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

