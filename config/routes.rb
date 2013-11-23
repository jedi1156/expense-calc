ExpenseCalc::Application.routes.draw do
	authenticated :user do
		root to: 'home#index'
	end
	root to: "home#index"
	resource :about, only: [ :show ]
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	resources :users
	resources :friends, only: [ :create, :destroy, :index ]
	resources :friend_requests, only: [ :create, :destroy, :index ]

	resources :reckonings do
		resources :user_reckonings, only: [ :create, :destroy ]
		resources :items
		resource :report, only: [ :create, :show ]
		resources :invitations, only: [ :destroy ]
	end
	post "/reckoning/:reckoning_id/user_reckonings/:id/make_admin", to: "user_reckonings#make_admin", as: :make_admin_reckoning_user_reckoning

	resources :items do
		resources :expenses
	end
	get "/item/:item_id/expenses/rest", to: "expenses#rest", as: :rest_item_expense
	get "/item/:item_id/expenses/even", to: "expenses#even", as: :even_item

end
