require 'open-uri'
require 'net/http'

class YoutubeLink < ApplicationRecord
  belongs_to :segment
  validates :link, presence: true
  validate :link_valid?

  def extract_video_id(link)
    # https://stackoverflow.com/a/61033353/13746045
    %r{(?:https?://)?(?:www\.)?youtu(?:\.be/|be.com/\S*(?:watch|embed)(?:(?:(?=/[^&\s\?]+(?!\S))/)|(?:\S*v=|v/)))([^&\s\?]+)}.match(link)[1] || nil
  end

  private

  def link_valid?
    uri = URI("https://www.youtube.com/oembed?url=#{link}&format=json")
    errors.add :link, message: 'invalid' if Net::HTTP.get(uri) == 'Bad Request'
  end
end
