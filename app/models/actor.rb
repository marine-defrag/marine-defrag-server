class Actor < VersionedRecord
  belongs_to :actor_type

  validates :code, presence: true
  validates :title, presence: true
end
