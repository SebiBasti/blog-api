FactoryBot.define do
  factory :youtube_link do
    link { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }

    trait :bad_link do
      link { 'https://www.youtube.com/watch?v=bad_link' }
    end
  end
end
