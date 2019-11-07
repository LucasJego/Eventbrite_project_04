Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Le programme redirige la page d'accueil vers la page qui indique tous les événements (méthode 'index' du controller 'events_controller')
  root 'events#index'

  resources :events
  resources :charges, only: [:new, :create]

end
