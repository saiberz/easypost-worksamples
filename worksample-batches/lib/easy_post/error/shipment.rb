module EasyPost
  module Error
    module Shipment
      FORCE_FAILED = EasyPost::Error::Base.new(422,
        "SHIPMENT.BUY.FORCE_FAILED",
        "The architect has forced this purchase to fail.")

      INVALID = EasyPost::Error::Base.new(400,
        "SHIPMENT.INVALID",
        "Not enough information was provided to create this shipment")

      POSTAGE_REQUIRED = EasyPost::Error::Base.new(422,
        "SHIPMENT.POSTAGE_LABEL.REQUIRED",
        "This shipment has not yet been purchased.")
      POSTAGE_LABEL_EXISTS = EasyPost::Error::Base.new(422,
        "SHIPMENT.POSTAGE_LABEL.EXISTS",
        "This shipment has already been purchased.")

      BUY_IN_PROGRESS = EasyPost::Error::Base.new(409,
        "SHIPMENT.BUY.IN_PROGRESS",
        "The purchase process has already started for this shipment.")
      BUY_FAILED = EasyPost::Error::Base.new(422,
        "SHIPMENT.BUY.FAILED",
        "We're sorry, an error has occurred while generating your shipping label.")

      SELECTED_RATE_REQUIRED = EasyPost::Error::Base.new(400,
        "SHIPMENT.SELECTED_RATE.REQUIRED",
        "Unable to purchase shipment without a valid selected_rate.")

    end
  end
end

