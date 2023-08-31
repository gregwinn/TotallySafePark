Rails.application.routes.draw do
  devise_for :users
  resources :dinosaurs
  resources :cages

  namespace :form_validations do
	  resources :cages, only: [:update, :create]
      resources :dinosaurs, only: [:update, :create]
  end
  root "cages#index"
end
