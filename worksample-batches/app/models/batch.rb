class Batch < ActiveRecord::Base
  include Concerns::PublicID
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  symbolize :state, in: [
    :creating,
    :creation_failed, # not all shipments in the batch were created
    :created,
    :purchasing,
    :purchase_failed, # not all shipments in the batch were purchased successfully
    :purchased
  ], scopes: true

  def self.public_id_prefix
    "batch"
  end

  def as_json(options = {})
    BatchPresenter.new(self).as_json(options)
  end

  def num_shipments
    0 # TODO implement after associating batches and shipments
  end

end

