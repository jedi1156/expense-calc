class FlowDecorator < Draper::Decorator
	decorates :flow
	delegate_all

	def money_value
		to_dolars(value)
	end

	def from
		from_user_reckoning.user
	end

	def to
		to_user_reckoning.user
	end
end
