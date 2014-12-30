class BlocksController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
  	@block = Block.new(block_params)
  	if @block.save
      render :json => @block.to_json
    else
      render :json => { :errors => @block.errors.full_messages }
  	end
  end

  def update
  	@block = Block.find(params[:id])
    if @block.update_attributes(block_params)
      render :json => @block.to_json
    else
      render :json => { :errors => @block.errors.full_messages }
    end
  end

  def destroy
    Block.find(params[:id]).destroy
    render :json => true
  end

  private
  def block_params
    params.require(:block).permit(:label)
  end
end
