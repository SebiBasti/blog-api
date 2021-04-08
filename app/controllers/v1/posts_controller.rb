class V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = current_user.posts
    json_response(PostSerializer.new(@posts).serializable_hash)
  end

  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  def show
    json_response(PostSerializer.new(@post).serializable_hash)
  end

  def update
    @post.update(post_params)
    head :no_content
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:title, :sub_title)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
