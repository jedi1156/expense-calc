class UserReckoningDecorator < Draper::Decorator
	delegate_all
	decorate :user_reckoning

	def user_name
		user.to_s
	end
end
