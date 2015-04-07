module EasyPost
  module Interactor
    class ShipmentCreate
      include ::Interactor

      delegate :params, :user, :mode, to: :context

      before :validate_request

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
              400, "SHIPMENT.CREATE.ERROR", error.message
            )
          )
        end
      end

      def validate_request
        if params.nil?
          context.fail!(error: EasyPost::Error::Shipment::INVALID)
        end
      end

      def to_address
        @to_address ||= if params[:to_address].present?
          Address.find_or_create(params[:to_address], user, mode)
        end
      end

      def from_address
        @from_address ||= if params[:from_address].present?
          Address.find_or_create(params[:from_address], user, mode)
        end
      end

      def parcel
        @parcel ||= if params[:parcel].present?
          Parcel.find_or_create(params[:parcel], user, mode)
        end
      end

      def call
        context.shipment = Shipment.new(
          user:                 user,
          mode:                 mode,
          reference:            params[:reference],
          to_address:           to_address,
          from_address:         from_address,
          parcel:               parcel
        )

        unless context.shipment.save
          context.fail!(
            error: EasyPost::Error::Shipment::INVALID.with(
              message: context.shipment.errors.full_messages.join(", ")
            )
          )
        end

        context.shipment.get_rates
      end
    end
  end
end

