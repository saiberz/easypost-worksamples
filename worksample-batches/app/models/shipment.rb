class Shipment < ActiveRecord::Base
  include Concerns::UserOwnable
  include Concerns::Moded
  include Concerns::PublicID
  include Concerns::Messages

  attr_protected # all attrs are accessible

  belongs_to :to_address, class_name: "Address"
  belongs_to :from_address, class_name: "Address"
  belongs_to :selected_rate, class_name: "Rate"
  belongs_to :parcel
  belongs_to :postage_label

  has_many :rates

  serialize :messages, Set

  def self.public_id_prefix
    'shp'
  end

  def as_json(options = {})
    ShipmentPresenter.new(self).as_json(options)
  end

  def purchased?
    postage_label.present?
  end

  def get_rates
    return rates if selected_rate

    sleep(1) # simulates real world rate fetching, do not remove

    Rate.create(rate_cents: 500, service: "Priority Mail",
      carrier: "USPS", user: user, mode: mode, shipment_id: self.id)
    Rate.create(rate_cents: 1000, service: "Priority Mail Express",
      carrier: "USPS", user: user, mode: mode, shipment_id: self.id)
    if parcel.try(:weight) < 13
      Rate.create(rate_cents: 250, service: "First-Class",
        carrier: "USPS", user: user, mode: mode, shipment_id: self.id)
    end

    reload.rates
  end

end

