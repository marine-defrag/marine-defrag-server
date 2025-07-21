# frozen_string_literal: true

class User < VersionedRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :lockable
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

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

  scope :active, -> { where(is_archived: false) }

  def active_for_authentication?
    super && !is_archived
  end

  def active?
    !is_archived
  end

  def role?(role)
    roles.where(name: role).any?
  end
end
