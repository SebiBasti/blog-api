class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :sub_title
  has_many :segments

  attribute :author do |object|
    User.find(object.user_id).name
  end
end
