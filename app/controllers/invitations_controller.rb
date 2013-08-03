class InvitationsController < ApplicationController
	expose(:reckoning)
	expose(:invitation, model: :user)
	expose(:user) { reckoning.invitations.detect { |inv| inv == invitation } }

	def destroy
		authorize! :cancel_invitation, reckoning
		if user
			reckoning.invitations.delete(user)
			reckoning.save
		end
		if user == current_user
			redirect_to reckonings_path
		else
			redirect_to reckoning
		end
	end
end
