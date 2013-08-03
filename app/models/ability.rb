class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new


		alias_action :new, :create, to: :c
		alias_action :c, :read, to: :cr


		can :read, User


		can :c, Reckoning
		can :read, Reckoning do |reckoning|
			user.user_reckonings.any? { |ur| ur.reckoning == reckoning }
		end

		can :manage, Reckoning do |reckoning|
			ur = user.find_user_reckoning(reckoning.id)
			ur && ur.admin_rights
		end


		can :cancel_invitation, Reckoning do |reckoning|
			(can? :manage, reckoning) || (reckoning.invitations.include? user)
		end


		can :destroy, UserReckoning do |user_reckoning|
			(user_reckoning.user == user) || ((can? :manage, user_reckoning.reckoning) && !user_reckoning.admin_rights)
		end


		can :make_admin, UserReckoning do |user_reckoning|
			user_reckoning.reckoning.admins.include? user
		end


		can :read, FriendRequest
		can :manage, FriendRequest do |fr|
			(fr.from_user == user) || (fr.to_user == user)
		end
	end
end
