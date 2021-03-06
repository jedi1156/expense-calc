class FriendRequest
	include Mongoid::Document

	belongs_to :from_user, class_name: "User", inverse_of: :friend_requests_to
	belongs_to :to_user, class_name: "User", inverse_of: :friend_requests_from

	validates :from_user, presence: true
	validates :to_user, presence: true

	def friend(current_user)
		from_user == current_user ? to_user : from_user
	end
end
