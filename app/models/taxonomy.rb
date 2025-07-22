class Taxonomy < ApplicationRecord
  has_many :actortype_taxonomies, dependent: :destroy
  has_many :actortypes, through: :actortype_taxonomies

  has_many :categories, dependent: :destroy
  belongs_to :taxonomy, class_name: "Taxonomy", foreign_key: :parent_id, optional: true
  has_many :taxonomies, class_name: "Taxonomy", foreign_key: :parent_id

  has_many :framework_taxonomies, inverse_of: :taxonomy, dependent: :destroy
  has_many :frameworks, through: :framework_taxonomies
  belongs_to :framework, optional: true

  has_many :measuretype_taxonomies, dependent: :destroy
  has_many :measuretypes, through: :measuretype_taxonomies

  validates :title, presence: true

  validates :allow_multiple, inclusion: [true, false]

  validate :different_parent
  validate :sub_relation

  def different_parent
    return unless self.class.column_names.include?("parent_id") && parent_id.present?
    if parent_id == id
      errors.add(:parent_id, "Taxonomy can't be its own parent")
    end
  end

  def sub_relation
    return unless self.class.column_names.include?("parent_id") && parent_id.present?
    if !taxonomy.parent_id.nil?
      errors.add(:parent_id, "Parent taxonomy is already a sub-taxonomy")
    end
  end
end
