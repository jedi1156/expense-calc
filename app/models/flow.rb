class Flow
	include Mongoid::Document

	field :value, type: Integer

	belongs_to :reckoning

	belongs_to :from_user, class_name: "UserReckoning", inverse_of: :debts_owed
	belongs_to :to_user, class_name: "UserReckoning", inverse_of: :loans_given

	validates :reckoning, uniquness: { scope: [ :from_user, :to_user ] }
end
