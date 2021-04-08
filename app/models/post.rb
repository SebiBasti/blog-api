class Post < ApplicationRecord
  belongs_to :user
  has_many :segments, dependent: :destroy
  validates :title, presence: true
end
