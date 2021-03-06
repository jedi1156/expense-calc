class Expense
	include Mongoid::Document
	include MoneyRoutines

	field :paid, type: Integer, default: 0
	field :used, type: Integer, default: 0

	belongs_to :user_reckoning
	belongs_to :item

	validates :item, uniqueness: { scope: :user_reckoning }, presence: true
	validates :user_reckoning, presence: true

	def empty?
		(paid == 0) && (used == 0)
	end

	def user
		user_reckoning.user
	end

	def value
		paid - used
	end
end
