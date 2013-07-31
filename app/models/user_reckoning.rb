class UserReckoning
	include Mongoid::Document

	field :admin_rights, type: Boolen
	belongs_to :user
	belongs_to :reckoning
	
	has_many :expenses

	has_many :debts_owed, class_name: "Flow", inverse_of: :from_user
	has_many :loans_given, class_name: "Flow", inverse_of: :to_user

	validates :user, uniqueness: { scope: :reckoning }
end
