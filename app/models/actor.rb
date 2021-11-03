class Actor < VersionedRecord
  belongs_to :actortype, required: true

  validates :code, presence: true
  validates :title, presence: true
end
