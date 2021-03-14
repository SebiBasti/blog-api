Rails.application.routes.draw do
  resources :posts do
    resources :segments
  end
end
