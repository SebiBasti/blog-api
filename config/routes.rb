Rails.application.routes.draw do
  root to: 'posts#index'
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :posts do
    resources :segments do
      resource :text_block
      resource :code_block
      resource :youtube_link
      resource :picture
    end
  end
end
