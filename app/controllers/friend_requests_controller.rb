class FriendRequestsController < ApplicationController
	expose(:friend_request)
	expose(:requests_to) { current_user.friend_requests_to }
	expose(:requests_from) { current_user.friend_requests_from }

	def create
		friend_request.from_user = current_user
		friend_request.to_user = User.find(params[:friend_id])
		if friend_request.save
			flash[:notice] = "Sent friend request to #{friend_request.to_user.to_s}"
		else
			flash[:error] = "Error, couldn't send that request"
		end
		redirect_to action: :index
	end

	def destroy
		if friend_request.from_user == current_user
			flash[:notice] = "Cancelled friend request sent to #{friend_request.to_user.to_s}"
			friend_request.destroy
		elsif friend_request.to_user == current_user
			flash[:notice] = "Rejected friend request sent by #{friend_request.from_user.to_s}"
			friend_request.destroy
		else
			flash[:error] = "Not your thing to touch"
		end
		redirect_to action: :index
	end

	def index
	end
end
