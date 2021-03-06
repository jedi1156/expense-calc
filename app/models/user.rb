class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook]

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name, type: String
  field :provider, type: String
  field :uid, type: String

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  index({ email: 1 }, { unique: true, background: true })
  validates :name, presence: true
  attr_accessible :name, :provider, :uid, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  has_many :user_reckonings, dependent: :destroy
  has_and_belongs_to_many :invitations, class_name: "Reckoning", inverse_of: :invitations

  has_and_belongs_to_many :friends, class_name: "User"
  has_many :friend_requests_to, class_name: "FriendRequest", inverse_of: :from_user
  has_many :friend_requests_from, class_name: "FriendRequest", inverse_of: :to_user

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name: auth.extra.raw_info.name,
                        provider: auth.provider,
                        uid: auth.uid,
                        email: auth.info.email,
                        password: Devise.friendly_token[0,20])
    end
    user
  end

  def find_user_reckoning(reckoning_id)
    user_reckonings.detect { |ur| ur.reckoning_id == reckoning_id }
  end

  def to_s
    name
  end
end
