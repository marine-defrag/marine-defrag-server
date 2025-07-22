# frozen_string_literal: true

class User < VersionedRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :lockable, :password_expirable

  include DeviseTokenAuth::Concerns::User

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :managed_categories, foreign_key: :manager_id, class_name: "Category"
  has_many :managed_indicators, foreign_key: :manager_id, class_name: "Indicator"
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :bookmarks, dependent: :destroy

  validates :email, presence: true
  validates :name, presence: true
  validates :password, secure_password: true, if: :password_required?

  before_update :set_password_changed_at, if: :saved_change_to_encrypted_password?

  scope :active, -> { where(is_archived: false) }

  def active_for_authentication?
    super && !is_archived
  end

  def inactive_message
    return :archived if is_archived
    return :locked if access_locked?
    super
  end

  def active?
    !is_archived
  end

  def role?(role)
    roles.where(name: role).any?
  end

  private

  def set_password_changed_at
    self.password_changed_at = Time.current
  end

end
