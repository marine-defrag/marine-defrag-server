class ActorType < VersionedRecord
  has_many :actors

  validates :title, presence: true
end
