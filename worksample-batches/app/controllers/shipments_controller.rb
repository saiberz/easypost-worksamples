class ShipmentsController < ApplicationController
  before_filter :ensure_signed_in

  # GET /shipments
  def index
    render json: Shipment.where(user_id: current_user.id, mode: current_mode)
  end

  # GET /shipments/:id
  def show
    render json: find_member
  end

  # POST /shipments
  def create
    result = EasyPost::Interactor::ShipmentCreate.call(
      params: params[:shipment],
      user: current_user,
      mode: current_mode
    )
    render_result :shipment, result,
      status: :created,
      location: "#{shipments_path}/#{result.shipment.try(:public_id)}"
  end

  # POST /shipments/:id/buy
  def buy
    result = EasyPost::Interactor::ShipmentBuy.call(
      params: params[:rate],
      shipment: find_member
    )
    render_result :shipment, result
  end

  private

  def find_member(params)
    unless shipment = Shipment.where(
        user_id: current_user.id,
        mode: current_mode,
        public_id: params[:id]
    ).first
      raise EasyPost::Error::NOT_FOUND unless shipment
    end
    shipment
  end
end

