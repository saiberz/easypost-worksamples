class ShipmentPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      messages: @object.messages,
      reference: @object.reference,
      from_address: @object.from_address,
      to_address: @object.to_address,
      parcel: @object.parcel,
      rates: @object.rates,
      selected_rate: @object.selected_rate,
      postage_label: @object.postage_label,
      tracking_code: @object.tracking_code,
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

