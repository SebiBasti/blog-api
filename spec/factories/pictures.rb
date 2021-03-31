FactoryBot.define do
  factory :picture do
    trait :is_external_link do
      external_link { 'https://de.wikipedia.org/wiki/Ruby_(Programmiersprache)#/media/Datei:Ruby_logo.svg' }
    end
    trait :is_cloudinary_link do
      photo { Rack::Test::UploadedFile.new('spec/support/assets/test.jpg', 'image/jpg') }
    end
  end
end

