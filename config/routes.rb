Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :courses do
    resources :lessons, only: %i[show new create edit update destroy]

    post 'enroll', on: :member
    get 'my_enroll', on: :collection
  end
  resources :teachers
end
