class Invitation
	include Mongoid::Document

	field :message, type: String
	belongs_to :reckoning
	belongs_to :from_user, class_name: "User", inverse_of: :invitations_from
	belongs_to :for_user, class_name: "User", inverse_of: :invitations_for
end
