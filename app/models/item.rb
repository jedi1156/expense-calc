class Item
  include Mongoid::Document
  include MoneyRoutines
  field :name, type: String
  field :description, type: String
  field :bought_at, type: Time

  belongs_to :reckoning
  has_many :expenses, dependent: :destroy

  def cost
  	@cost ||= expenses.inject(0) { |mem, it| mem + it.paid }
  end

  def used
  	@used ||= expenses.inject(0) { |mem, it| mem + it.used }
  end

  def cost_valid?
  	cost == used
  end
end
