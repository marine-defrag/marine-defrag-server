# frozen_string_literal: true

class User < VersionedRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_paper_trail ignore: [:tokens, :updated_at]

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

  scope :active, -> { where(is_archived: false) }

  def active_for_authentication?
    super && !locked_at
  end

  def active?
    !is_archived
  end

  def locked_at
    updated_at unless active?
  end

  def role?(role)
    roles.where(name: role).any?
  end
end
