FactoryBot.define do
  factory :measure_type_taxonomy do
    association :measure_type
    association :taxonomy
  end
end
