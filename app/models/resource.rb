class Resource < VersionedRecord
  belongs_to :type, class_name: "Resourcetype"

  validates :title, presence: true
  validates :resourcetype_id, presence: true
end
