FactoryBot.define do
  factory :actor_measure do
    association :actor
    association :measure

    date_start { Date.new(2021, 11, 2) }
    date_end { Date.new(2021, 11, 2) }
    value { 3.14 }
  end
end
