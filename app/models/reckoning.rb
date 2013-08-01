class Reckoning
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :created_at, type: Time, default: Time.current
  field :report_valid, type: Boolean

  has_many :user_reckonings, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :flows, dependent: :destroy

  def users
  	user_reckonings.map { |ur| ur.user }
  end
end
