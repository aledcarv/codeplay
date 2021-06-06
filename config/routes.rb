Rails.application.routes.draw do
  devise_for :users
  devise_for :students
  root 'home#index'
  
  namespace :admin do
    resources :courses do
      resources :lessons, only: %i[show new create edit update destroy]
    end

    resources :teachers
  end

  namespace :student do
    resources :courses, only: %i[index show] do
      resources :lessons, only: %i[show]
  
      post 'enroll', on: :member
      get 'my_enroll', on: :collection
    end
  end

  resources :courses, only: %i[index show]

  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show create], param: :code
    end
  end
end
