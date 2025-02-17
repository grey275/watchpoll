Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do # /api/data
    resources :rooms, only: [:index, :create, :show] do
      post :run
      post :cycle
      resources :video_polls do
        resources :preference_orders, only: [:create]
      end
      resources :user_sessions, only: [:create]
    end
  end


  mount ActionCable.server => '/cable'


  get '/rooms' => 'pages#index'

  match '*path', to: redirect('/rooms'), via: :all
  # get '*path', to: "pages#fallback_index_html", constraints: ->(request) do
  #   !request.xhr? && request.format.html?
  # end
end
