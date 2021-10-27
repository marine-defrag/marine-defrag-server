FactoryBot.define do
  factory :measure_type do
    title { Faker::Creature::Cat.registry }

    trait :parent_allowed do
      has_parent { true }
    end

    trait :parent_not_allowed do
      has_parent { false }
    end
  end
end
