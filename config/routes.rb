Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :segments do
      resource :text_block
      resource :code_block
      resource :youtube_link
      resource :picture
    end
  end
end
