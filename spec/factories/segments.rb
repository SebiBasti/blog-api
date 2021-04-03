FactoryBot.define do
  factory :segment do
    segment_type { %w[text_block code_block picture youtube_link].sample }

    trait :is_text_block do
      segment_type { 'text_block' }
    end
    trait :is_code_block do
      segment_type { 'code_block' }
    end
    trait :is_youtube_link do
      segment_type { 'youtube_link' }
    end
    trait :is_picture do
      segment_type { 'picture' }
    end
  end
end
