class PostageLabel < ActiveRecord::Base
  include Concerns::PublicID
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  belongs_to :rate
  has_one :shipment

  before_validation :set_defaults

  def self.public_id_prefix
    "pl"
  end

  def as_json(options = {})
    PostageLabelPresenter.new(self).as_json(options)
  end

  private

  def set_defaults
    self.label_date       ||= Time.now
    self.label_resolution ||= 300
    self.label_width      ||= 4
    self.label_height     ||= 6
  end
end

