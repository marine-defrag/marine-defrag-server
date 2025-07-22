# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "1lj#hIKekU17" }
    password_confirmation { password }
    password_changed_at { Time.current }
  end

  trait :admin do
    roles { [create(:role, :admin)] }
  end

  trait :manager do
    roles { [create(:role, :manager)] }
  end

  trait :analyst do
    roles { [create(:role, :analyst)] }
  end

  trait :active do
    is_archived { false }
  end

  trait :archived do
    is_archived { true }
  end
end
