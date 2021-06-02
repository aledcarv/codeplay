Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  namespace :admin do
    resources :courses do
      resources :lessons, only: %i[show new create edit update destroy]
    end
  end

  resources :courses, only: %i[show] do
    resources :lessons, only: %i[show new create edit update destroy]

    post 'enroll', on: :member
    get 'my_enroll', on: :collection
  end
  resources :teachers
end
