class Expense
	include Mongoid::Document
	include MoneyRoutines

	field :paid, type: Integer
	field :used, type: Integer

	belongs_to :user_reckoning
	belongs_to :item

	validates :item, uniqueness: { scope: :user_reckoning }

	def empty?
		(paid == 0) && (used == 0)
	end

	def user
		user_reckoning.user
	end

	def set_values(expense)
		self.paid = to_cents(expense[:paid])
		self.used = to_cents(expense[:used])
	end
end
