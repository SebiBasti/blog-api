class PicturesController < ApplicationController
  before_action :set_segment
  before_action :set_segment_picture, only: [:show, :update, :destroy]

  def show
    json_response(@picture)
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.segment = @segment
    @picture.save!
    json_response(@picture, :created)
  end

  def update
    @picture.update(picture_params)
    head :no_content
  end

  def destroy
    @picture.destroy
    head :no_content
  end

  private

  def picture_params
    params.permit(:external_link, :photo)
  end

  def set_segment
    @segment = Segment.find(params[:segment_id])
  end

  def set_segment_picture
    @picture = @segment.picture if @segment
  end
end
