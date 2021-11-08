class Actor < VersionedRecord
  belongs_to :actortype, required: true

  validates :title, presence: true
end
