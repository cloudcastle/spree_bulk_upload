Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :bulk_uploads, only: [:index,:create, :new] do
      get :bulk_upload_errors
    end
  end
end
