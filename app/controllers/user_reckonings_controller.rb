class UserReckoningsController < ApplicationController
	expose(:reckoning)
	expose(:user_reckoning)

	authorize_resource decent_exposure: true, only: [ :destroy, :make_admin ]

	def create
		authorize! :cancel_invitation, reckoning
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

		if !f && reckoning.admins.empty?
			ur = reckoning.user_reckonings.first
			ur.admin_rights = true
			ur.save
		end

		if f || (user_reckoning.user == current_user)
			redirect_to reckonings_path
		else
			redirect_to reckoning
		end
	end

	def make_admin
		user_reckoning.admin_rights = true
		if user_reckoning.save
			flash[:notice] = "#{user_reckoning.user} is now also an admin"
		else
			flash[:error] = "You can't do that!"
		end
		redirect_to reckoning
	end

end
