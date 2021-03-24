class CodeBlocksController < ApplicationController
  before_action :set_segment
  before_action :set_segment_code_block, only: [:show, :update, :destroy]

  def show
    json_response(@code_block)
  end

  def create
    @code_block = CodeBlock.new(code_block_params)
    @code_block.segment = @segment
    @code_block.save!
    json_response(@code_block, :created)
  end

  def update
    @code_block.update(code_block_params)
    head :no_content
  end

  def destroy
    @code_block.destroy
    head :no_content
  end

  private

  def code_block_params
    params.permit(:content, :code_type)
  end

  def set_segment
    @segment = Segment.find(params[:segment_id])
  end

  def set_segment_code_block
    @code_block = @segment.code_block if @segment
  end
end
