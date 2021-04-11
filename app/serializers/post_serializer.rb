class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :sub_title

  attribute :author do |object|
    User.find(object.user_id).name
  end

  attribute :created_at do |object|
    object.created_at.in_time_zone('Berlin').iso8601(0)
  end

  attribute :updated_at do |object|
    object.updated_at.in_time_zone('Berlin').iso8601(0)
  end

  attribute :segments do |object|
    SegmentSerializer.new(object.segments)
  end
end
