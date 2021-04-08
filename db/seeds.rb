require 'faker'

puts '*** Deleting old seed data ***'
Post.destroy_all

puts '*** Creating test user ***'
user = User.new(name: 'test_user', email: 'foo@bar.com', password: 'foobar')
user.save

puts '*** Creating 10 posts ***'
10.times do
  new_post = Post.new(title: Faker::Lorem.question)
  new_post.user = user
  new_post.save
  p new_post
  5.times do
    segm = Segment.new(segment_type: %w[text_block code_block picture youtube_link].sample)
    segm.post = new_post
    segm.save
    p segm
  end
end

# TODO: -update seeds
