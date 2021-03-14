class SegmentsController < ApplicationController
  before_action :set_post
  before_action :set_post_segment, only: [:show, :update, :destroy]

  def index
    json_response(@post.segments)
  end

  def show
    json_response(@segment)
  end

  def create
    @post.segments.create!(segment_params)
    json_response(@post, :created)
  end

  def update
    @segment.update(segment_params)
    head :no_content
  end

  def destroy
    @segment.destroy
    head :no_content
  end

  private

  def segment_params
    params.permit(:segment_type)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_segment
    @segment = @post.segments.find_by!(id: params[:id]) if @post
  end
end
