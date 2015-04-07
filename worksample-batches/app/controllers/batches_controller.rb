class BatchesController < ApplicationController
  before_filter :ensure_signed_in

  # GET /batches
  def index
    render json: Batch.where(user: current_user, mode: current_mode)
  end

  # GET /batches/:id
  def show
    render json: find_member
  end

  # POST /batches
  def create
    batch = Batch.create(user: current_user, mode: current_mode, state: :creating)
    EasyPost::Job::BatchCreate.pool(params[:batch], batch.id)

    render json: batch, status: :created, location: "#{batches_path}/#{@batch.try(:public_id)}"
  end

  # POST /batches/:id/buy
  def buy
    # EasyPost::Job::BuyBatch.pool(find_member.id)
    # render ...
  end

  private

  def find_member
    unless batch = Batch.where(user_id: current_user.id,
        mode: current_mode,
        public_id: params[:id]
    ).first
      raise EasyPost::Error::NOT_FOUND unless batch
    end
    batch
  end
end

