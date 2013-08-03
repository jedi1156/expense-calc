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

	def destroy
		user_reckoning.destroy
		if (f = reckoning.user_reckonings.empty?)
			reckoning.destroy
		end
		if f || (user_reckoning.user == current_user)
			redirect_to reckonings_path
		else
			redirect_to reckoning
		end
	end

end
