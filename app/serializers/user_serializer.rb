class UserSerializer
  include FastJsonapi::ObjectSerializer
  attribute :name
  has_many :posts
end
