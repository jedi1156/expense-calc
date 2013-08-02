ExpenseCalc::Application.routes.draw do
	authenticated :user do
		root to: 'home#index'
	end
	root to: "home#index"
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	resources :users
	resources :friends, only: [ :create, :destroy, :index ]
	resources :friend_requests, only: [ :create, :destroy, :index ]

	resources :reckonings do
		resources :user_reckonings
		resources :items
		resource :report, only: [ :create, :show ]
	end

	resources :items do
		resources :expenses
	end

	get "/item/:item_id/expenses/rest", to: "expenses#rest", as: :rest_item_expense
end
