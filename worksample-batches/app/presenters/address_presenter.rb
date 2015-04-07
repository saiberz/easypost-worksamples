class AddressPresenter < BasePresenter
  def as_json(options = {})
    {
      object: class_name,
      id: @object.public_id,
      mode: @object.mode,
      name: @object.name,
      company: @object.company,
      address_line_1: @object.address_line_1,
      address_line_2: @object.address_line_2,
      city: @object.city,
      state: @object.state,
      postal_code: @object.postal_code,
      country: @object.country,
      phone: @object.phone,
      email: @object.email,
      residential: @object.residential,
      created_at: @object.created_at,
      updated_at: @object.updated_at,
    }
  end
end

