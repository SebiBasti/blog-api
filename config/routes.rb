Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  # scope module: :v2, constraints: ApiVersion.new('v2') do
  #   resources :posts, only: :index
  # end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    root to: 'posts#index' # TODO: does this work with versioning?

    resources :posts do
      resources :segments do
        resource :text_block
        resource :code_block
        resource :youtube_link
        resource :picture
      end
    end
  end
end
