class BlocksController < ApplicationController
  def new
  	@block = Block.new
  	3.times { @block.questions.build }
  end

  def create
  	@block = Block.new(params[:block])
  	if @block.save
  	  flash[:notice] = "Block created succesfully."
  	  redirect_to @block
  	else
  	  render :action => 'new'
  	end
  end

  def show
  	@block = Block.find(params[:id])
  end

  def edit
  	@block = Block.find(params[:id])
  end

  def add(block_id, question_id)
  end

  def destroy
  end

  def fillOut
  end
end
