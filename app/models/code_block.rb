class CodeBlock < ApplicationRecord
  belongs_to :segment
  validates :content, presence: true
  validates :code_type, presence: true
end
