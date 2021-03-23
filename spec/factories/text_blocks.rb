FactoryBot.define do
  factory :text_block do
    content { Faker::Lorem.paragraph(sentence_count: 10) }
  end
end
