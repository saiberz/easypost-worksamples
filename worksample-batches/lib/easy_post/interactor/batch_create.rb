module EasyPost
  module Interactor
    class BatchCreate
      include ::Interactor

      delegate :params, :batch, to: :context

      before :symbolize_params

      def symbolize_params
        params.deep_symbolize_keys! if params.is_a?(Hash)
      end

      def call
        params.try(:fetch, :shipments, {}).values.each do |shipment|
          # TODO handle the case where a customer has provided a shipment that
          # already exists

          # TODO this isn't going to scale to hundreds or thousands of shipments

          # TODO associate this newly created shipment to the batch
          result = Interactor::ShipmentCreate.call(
            params: shipment,
            user: batch.user,
            mode: batch.mode)
        end
      end

    end
  end
end
