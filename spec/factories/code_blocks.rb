FactoryBot.define do
  factory :code_block do
    code_type { Faker::Lorem.word }
    content { Faker::Lorem.paragraph(sentence_count: 10) }
  end
end
