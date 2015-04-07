WorksampleBatches::Application.routes.draw do
  # api routes
  scope '(/api)', defaults: {format: :json} do
    resource :session, only: [:create]

    resources :addresses, only: [:index, :show, :new, :create]
    resources :parcels, only: [:index, :show, :new, :create]

    resources :batches, only: [:index, :show, :new, :create] do
      # collection { post :create_and_buy }
      member do
        post :buy
        # post :remove_shipments
        # post :add_shipments
      end
    end

    resources :shipments, only: [:index, :show, :new, :create] do
      member do
        post :buy
      end
    end
  end

end

