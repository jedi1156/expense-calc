class UserReckoningsController < ApplicationController
	expose(:reckoning)
	expose(:user_reckoning)

	def create
		reckoning.user_reckonings.build(user_id: current_user.id)
		redirect_to reckoning
	end

end
