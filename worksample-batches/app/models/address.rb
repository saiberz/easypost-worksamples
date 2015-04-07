class Address < ActiveRecord::Base
  include Concerns::PublicID
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  def self.public_id_prefix
    "adr"
  end

  def as_json(options = {})
    AddressPresenter.new(self).as_json(options)
  end

  def self.find_or_create(attributes, user, mode)
    if attributes.blank?
      nil
    elsif attributes[:id].present?
      Address.find_by_user_id_and_mode_and_public_id(user.id, mode, attributes[:id])
    else
      create(attributes.merge(user: user, mode: mode))
    end
  end

end

