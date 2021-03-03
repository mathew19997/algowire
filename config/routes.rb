Rails.application.routes.draw do
	root "home#index"
	resources :users, except: [:show, :index, :destroy] do
		get :forgot_password, on: :collection, format: false
		post :forgot_password, on: :collection, format: false
	end
	resources :sessions, only: [:new, :create, :destroy]
	resources :home, only: [:index] do
		get :sample, on: :collection, format: false
	end
end
