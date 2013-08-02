class Reckoning
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :created_at, type: Time, default: Time.current
  field :report_valid, type: Boolean, default: false

  has_many :user_reckonings, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :flows, dependent: :destroy

  has_and_belongs_to_many :invitations, class_name: "User", inverse_of: :invitations

  def users
  	user_reckonings.map { |ur| ur.user }
  end

  def admin
    if ur = user_reckonings.detect { |ur| ur.admin_rights }
      ur.user
    end
  end
end
