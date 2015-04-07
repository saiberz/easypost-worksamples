class BatchPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      reference: @object.reference,
      state: @object.state,
      num_shipments: @object.num_shipments,
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

