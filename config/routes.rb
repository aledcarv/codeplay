Rails.application.routes.draw do
  root 'home#index'
  
  resources :courses, only: %i[index show new create edit update]
  resources :teachers
end
