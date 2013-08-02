class ExpenseDecorator < Draper::Decorator
	decorates :expense
	delegate_all

	def user_name
		user_reckoning.user.to_s
	end

	def money_paid
		to_dolars(paid)
	end

	def money_used
		to_dolars(used)
	end
end
