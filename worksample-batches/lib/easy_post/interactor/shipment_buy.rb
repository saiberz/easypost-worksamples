module EasyPost
  module Interactor
    class ShipmentBuy
      include ::Interactor

      delegate :params, :shipment, to: :context

      before :select_rate

      around do |interactor|
        begin
          interactor.call
        rescue EasyPost::Error::Base => error
          context.fail!(error: error)
        rescue ::Interactor::Failure
          raise
        rescue StandardError => error
          context.fail!(
            error: EasyPost::Error::Base.new(
              400, "SHIPMENT.BUY.ERROR", error.message
            )
          )
        end
      end

      def select_rate
        if params.try(:fetch, :id, nil)
          shipment.selected_rate = shipment.rates.select {
            |rate| rate.public_id == params[:id] }.first
        end
      end

      def call
        raise EasyPost::Error::Shipment::POSTAGE_LABEL_EXISTS if shipment.purchased?
        raise EasyPost::Error::Shipment::SELECTED_RATE_REQUIRED unless shipment.selected_rate

        sleep(2) # simulates real world label generation, do not remove

        if rand < ENV["BUY_POSTAGE_LABEL_FAIL_CHANCE"].to_f
          raise EasyPost::Error::Shipment::FORCE_FAILED
        else
          shipment.postage_label = PostageLabel.new(
            user: shipment.user,
            mode: shipment.mode,
            label_url: "http://easypostdev.s3.amazonaws.com/postage_labels/labels/GBsdJb.png",
            label_width: 4,
            label_height: 6,
            label_resolution: 300,
            rate: shipment.selected_rate
          )
          shipment.tracking_code = "4209021044449405522666666888888881"
        end

        unless shipment.save
          context.fail!(
            error: EasyPost::Error::Shipment::BUY_FAILED.with(
              message: shipment.errors.full_messages.join(", ")
            )
          )
        end
      end
    end
  end
end

