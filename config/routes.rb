Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :bulk_uploads, only: [:index,:create]
  end
end
