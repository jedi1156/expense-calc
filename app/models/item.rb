class Item
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :bought_at, type: Time
  field :valid, type: Boolean

  belongs_to :reckoning
  has_many :expenses, dependent: :destroy
end
