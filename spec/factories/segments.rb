FactoryBot.define do
  factory :segment do
    type { %w[text_block code_block picture youtube_link].sample }
    post_id nil
  end
end
