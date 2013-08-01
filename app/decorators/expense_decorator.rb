class ExpenseDecorator < Draper::Decorator
	delegate_all
	decorate :expense

	def user_name
		user_reckoning.user.to_s
	end
end
