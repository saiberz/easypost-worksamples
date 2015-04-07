class Parcel < ActiveRecord::Base
  include Concerns::PublicID
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  belongs_to :shipment

  validates :weight, presence: true, numericality: { greater_than: 0 }

  def self.public_id_prefix
    "prcl"
  end

  def as_json(options = {})
    ParcelPresenter.new(self).as_json(options)
  end

  def self.find_or_create(attributes, user, mode)
    if attributes.blank?
      nil
    elsif attributes[:id].present?
      Parcel.find_by_user_id_and_mode_and_public_id(user.id, mode, attributes[:id])
    else
      create(attributes.merge(user: user, mode: mode))
    end
  end

end

