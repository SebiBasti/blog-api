require 'faker'

puts '*** Deleting old seed data ***'
Post.destroy_all
User.destroy_all
puts '*** Deleting old pictures ***'
key_arr = Picture.where(external_link: nil).map { |picture| picture.photo.key }
key_arr.each { |key| Cloudinary::Uploader.destroy(key) }

puts '*** Creating test user ***'
user = User.new(name: 'test_user', email: 'foo@bar.com', password: 'foobar')
user.save

def external_link
  { external_link: 'https://de.wikipedia.org/wiki/Ruby_(Programmiersprache)#/media/Datei:Ruby_logo.svg' }
end

def cloudinary_picture
  { photo: Rack::Test::UploadedFile.new('spec/support/assets/test.jpg', 'image/jpg') }
end

puts '*** Creating 10 posts ***'
100.times do
  new_post = Post.new(title: Faker::Lorem.question, sub_title: Faker::Lorem.words(number: 2).join(' '))
  new_post.user = user
  new_post.save
  p new_post
  5.times do
    segm = Segment.new(segment_type: %w[text_block code_block picture youtube_link].sample)
    segm.post = new_post
    segm.save
    case segm.segment_type
    when 'text_block'
      text_block = TextBlock.new(content: Faker::Lorem.paragraph_by_chars(number: 500))
      text_block.segment = segm
      text_block.save
      p text_block
    when 'code_block'
      code_block = CodeBlock.new(
        code_type: %w[ruby html css javascript].sample,
        content: Faker::Lorem.paragraph_by_chars(number: 50))
      code_block.segment = segm
      code_block.save
      p code_block
    when 'picture'
      picture = Picture.new([external_link, cloudinary_picture].sample)
      picture.segment = segm
      picture.save
      p picture
    when 'youtube_link'
      youtube_link = YoutubeLink.new(link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ')
      youtube_link.segment = segm
      youtube_link.save
      p youtube_link
    end
    p segm
  end
end
