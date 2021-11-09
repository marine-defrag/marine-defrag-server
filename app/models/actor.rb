class Actor < VersionedRecord
  belongs_to :actortype, required: true
  has_many :memberships

  validates :code, presence: true
  validates :title, presence: true
end
