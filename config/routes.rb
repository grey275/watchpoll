Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do # /api/data
    resources :rooms, only: [:index] do
      post :run
      post :cycle
      resources :video_polls do
        resources :preference_orders, only: [:create]
      end
      resources :user_sessions, only: [:create]
    end
  end

  # get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
  #   !request.xhr? && request.format.html?
  # end

  mount ActionCable.server => '/cable'

end
