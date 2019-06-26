Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do # /api/data
    resources :rooms, only: [:index, :show] do
      resources :poll, only: [:create]
      resources :user_sessions, only: [:create]
    end
  end

  # get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
  #   !request.xhr? && request.format.html?
  # end

  mount ActionCable.server => '/cable'

end
