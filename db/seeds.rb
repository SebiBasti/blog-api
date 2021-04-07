require 'faker'

puts '*** Deleting old seed data ***'
Post.destroy_all
puts '*** Creating 100 posts ***'
100.times do
  new_post = Post.new(title: Faker::Lorem.question)
  new_post.save
  p new_post
  10.times do
    segm = Segment.new(segment_type: %w[text_block code_block picture youtube_link].sample)
    segm.post = new_post
    segm.save
    p segm
  end
end

# TODO: -update seeds
