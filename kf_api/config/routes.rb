Rails.application.routes.draw do
  resources :flashcards, only: %i[index destroy]
  resources :uploads, only: [:create] # Pluralized for consistency
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check
end
