class Expense
	include Mongoid::Document

	field :paid, type: Integer
	field :used, type: Integer

	belongs_to :user_reckoning
	belongs_to :item

	validates :item, uniqueness: { scope: :user_reckoning }
end
