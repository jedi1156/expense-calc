class Reckoning
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :created_at, type: Time, default: Time.current
  field :report_valid, type: Boolean

  has_many :user_reckonings
  has_many :items
  has_many :flows
end
