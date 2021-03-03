Rails.application.routes.draw do
	root "home#index"
	resources :users, except: [:show, :index, :destroy]
	resources :sessions, only: [:new, :create, :destroy]
	resources :home, only: [:index] do
		get :sample, on: :collection
	end
end
