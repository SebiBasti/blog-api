FactoryBot.define do
  factory :segment do
    segment_type { %w[text_block code_block picture youtube_link].sample }
  end
end
