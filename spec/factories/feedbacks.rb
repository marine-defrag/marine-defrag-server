FactoryBot.define do
  factory :feedback do
    association(:user)
    comment { Faker::Lorem.paragraph }
    rating { rand(1..5) }
  end
end
