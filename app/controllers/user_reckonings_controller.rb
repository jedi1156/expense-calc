class UserReckoningsController < ApplicationController
	expose(:reckoning)
	expose(:user_reckoning)

	def create
		ur = reckoning.user_reckonings.build(user_id: current_user.id)
		reckoning.invitations.delete(current_user)
		if ur.save && reckoning.save
			redirect_to reckoning
		else
			flash[:error] = "Something went wrong, try again"
			redirect_to reckonings_path
		end
	end

end
