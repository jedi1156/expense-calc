class Flow
	include Mongoid::Document
	include MoneyRoutines

	field :value, type: Integer

	belongs_to :reckoning

	belongs_to :from_user_reckoning, class_name: "UserReckoning", inverse_of: :debts_owed
	belongs_to :to_user_reckoning, class_name: "UserReckoning", inverse_of: :loans_given

	validates :reckoning, uniqueness: { scope: [ :from_user_reckoning, :to_user_reckoning ] }
end
