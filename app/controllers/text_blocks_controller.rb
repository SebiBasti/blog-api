class TextBlocksController < ApplicationController
  before_action :set_segment
  before_action :set_segment_text_block, only: [:show, :update, :destroy]

  def show
    json_response(@text_block)
  end

  def create
    @text_block = TextBlock.new(text_block_params)
    @text_block.segment = @segment
    @text_block.save!
    json_response(@text_block, :created)
  end

  def update
    @text_block.update(text_block_params)
    head :no_content
  end

  def destroy
    @text_block.destroy
    head :no_content
  end

  private

  def text_block_params
    params.permit(:content)
  end

  def set_segment
    @segment = Segment.find(params[:segment_id])
  end

  def set_segment_text_block
    @text_block = @segment.text_block if @segment
  end
end
