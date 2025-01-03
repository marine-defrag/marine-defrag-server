FactoryBot.define do
  factory :progress_report do
    association :indicator
    title { "MyString" }
    description { "MyText" }
    document_url { "MyString" }
    document_public { false }
    draft { false }
  end
end
