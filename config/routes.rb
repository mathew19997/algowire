Rails.application.routes.draw do
	resources :users, except: [:show, :index, :destroy]
	resources :home, only: [:index]
	root "home#index"
end
