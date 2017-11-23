FactoryBot.define do
  factory :note do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
  end
end