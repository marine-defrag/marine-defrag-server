class ActorMeasure < VersionedRecord
  self.table_name = :actors_measures

  belongs_to :actor, required: true
  belongs_to :measure, required: true

  validate :actor_actortype_is_active

  private

  def actor_actortype_is_active
    errors.add(:actor, "actor's actortype is not active") unless actor&.actortype&.is_active
  end
end
