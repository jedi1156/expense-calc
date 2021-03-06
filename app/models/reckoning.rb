class Reckoning
	include Mongoid::Document
	field :name, type: String
	field :description, type: String, default: ""
	field :created_at, type: Time, default: Time.current
	field :report_generated_at, type: Time


	has_many :user_reckonings, dependent: :destroy
	has_many :items, dependent: :destroy
	has_many :flows, dependent: :destroy

	has_and_belongs_to_many :invitations, class_name: "User", inverse_of: :invitations
	
	validates :name, presence: true

	def users
		user_reckonings.map { |ur| ur.user }
	end

	def admins
		adm = user_reckonings.map { |ur| ur.user if ur.admin_rights }
		adm.reject { |u| !u }
	end

	def total_cost
		items.inject(0) do |mem, it|
			if it.cost_valid?
				mem + it.cost
			else
				mem
			end
		end
	end

	def total_usage_by(user_reckoning)
		items.inject(0) do |mem, it|
			if it.cost_valid?
				mem + it.expense_of(user_reckoning).used
			else
				mem
			end
		end
	end

	def total_paid_by(user_reckoning)
		items.inject(0) do |mem, it|
			if it.cost_valid?
				mem + it.expense_of(user_reckoning).paid
			else
				mem
			end
		end
	end

	def total_balance_of(user_reckoning)
		items.inject(0) do |mem, it|
			if it.cost_valid?
				mem + it.expense_of(user_reckoning).value
			else
				mem
			end
		end
	end
end
