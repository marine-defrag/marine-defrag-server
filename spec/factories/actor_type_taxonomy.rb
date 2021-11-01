FactoryBot.define do
  factory :actor_type_taxonomy do
    association :actor_type
    association :taxonomy
  end
end
