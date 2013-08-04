class ReckoningDecorator < Draper::Decorator
	delegate_all
	decorate :reckoning

	include MoneyRoutines

	def admin
		admins.first
	end

	def total_money_cost
		to_dolars(total_cost)
	end

	def total_money_usage_by(user_reckoning)
		to_dolars(total_usage_by(user_reckoning))
	end

	def total_money_paid_by(user_reckoning)
		to_dolars(total_paid_by(user_reckoning))
	end

	def total_money_balance_of(user_reckoning)
		to_dolars(-total_balance_of(user_reckoning))
	end

	def total_balance_positive?(user_reckoning)
		total_balance_of(user_reckoning) > 0
	end

	def to_s
		name
	end

    def multiline_description
        description.gsub(/\n/, "<br>").html_safe
    end

	def date_of_creation
		created_at ? (l created_at) : ""
	end
end
