class YoutubeLinksController < ApplicationController
  before_action :set_segment
  before_action :set_segment_youtube_link, only: [:show, :update, :destroy]

  def show
    json_response(@youtube_link)
  end

  def create
    @youtube_link = YoutubeLink.new(youtube_link_params)
    @youtube_link.segment = @segment
    @youtube_link.save!
    json_response(@youtube_link, :created)
  end

  def update
    @youtube_link.update(youtube_link_params)
    head :no_content
  end

  def destroy
    @youtube_link.destroy
    head :no_content
  end

  private

  def youtube_link_params
    params.permit(:link)
  end

  def set_segment
    @segment = Segment.find(params[:segment_id])
  end

  def set_segment_youtube_link
    @youtube_link = @segment.youtube_link if @segment
  end
end
