class V1::PicturesController < ApplicationController
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
    # TODO: -check way to update cloudinary without creating duplicates
    # if params[:photo]
    #   Cloudinary::Uploader.destroy(@picture.photo.key) if params[:photo]
    #   @picture.destroy
    #   @picture = Picture.new(picture_params)
    #   @picture.segment = @segment
    #   @picture.save!
    # else

    @picture.update(picture_params)
    head :no_content
  end

  def destroy
    Cloudinary::Uploader.destroy(@picture.photo.key) if @picture.photo.key
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
