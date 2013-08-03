class FriendsController < ApplicationController
	expose(:friend_request) { FriendRequest.find_or_initialize_by(id: params[:friend_request_id]) }
	expose(:friend) { current_user.friends.detect { |f| f.id.to_s == params[:id] } }
	expose(:requested_friend) { friend_request.friend(current_user) }
	expose(:user_friends) { current_user.friends }

	authorize_resource :friend_request, decent_exposure: true, only: [ :create ]

	def create
		if requested_friend && (requested_friend != current_user)
			current_user.friends.push(requested_friend)
			current_user.save
			requested_friend.friends.push(current_user)
			requested_friend.save
			flash[:notice] = "Added friend"
		else
			flash[:error] = "Couldn't find friend"
		end
		friend_request.destroy
		redirect_to action: :index
	end

	def destroy
		if friend
			current_user.friends.delete(friend)
			current_user.save
			friend.friends.delete(current_user)
			friend.save
			flash[:notice] = "Removed friend"
		else
			flash[:error] = "Couldn't find friend"
		end
		redirect_to action: :index
	end

	def index
	end
end
