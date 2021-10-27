class Actor < VersionedRecord
  belongs_to :actor_type, required: true

  validates :code, presence: true
  validates :title, presence: true
end
