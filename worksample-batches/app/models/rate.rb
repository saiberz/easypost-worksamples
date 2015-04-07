class Rate < ActiveRecord::Base
  include Concerns::PublicID
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  belongs_to :shipment

  has_one :postage_label

  validates :rate_cents, presence: true
  validates :service,    presence: true
  validates :carrier,    presence: true

  def self.public_id_prefix
    "rate"
  end

  def as_json(options = {})
    RatePresenter.new(self).as_json(options)
  end

end

