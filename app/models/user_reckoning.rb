class UserReckoning
	include Mongoid::Document

	field :admin_rights, type: Boolean, default: false
	belongs_to :user
	belongs_to :reckoning

	has_many :expenses, dependent: :destroy

	has_many :debts_owed, class_name: "Flow", inverse_of: :from_user_reckoning, dependent: :destroy
	has_many :loans_given, class_name: "Flow", inverse_of: :to_user_reckoning, dependent: :destroy

	validates :user, uniqueness: { scope: :reckoning }
end
