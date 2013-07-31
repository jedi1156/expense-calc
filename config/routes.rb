ExpenseCalc::Application.routes.draw do
	authenticated :user do
		root to: 'home#index'
	end
	root to: "home#index"
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	resources :users do
		resources :user_reckonings
	end

	resources :reckonings do
		resources :items
	end

	resources :items do
		resources :expenses
	end
end
