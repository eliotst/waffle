class BlocksController < ApplicationController
  def new
  	@block = Block.new
  	3.times do |n|
  		@block.questions.build 
  	end  
  end

  def create
  	@block = Block.new(block_params)
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

  def index
  	@blocks = Block.paginate(page: params[:page])
  end

  def add(block_id, question_id)
  end

  def destroy
  	if current_user.admin?
  	  Block.find(params[:id]).destroy
      flash[:success] = "Block deleted."
      redirect_to blocks_path
    else
      flash[:notice] = "Only admins may delete a block."
    end
  end

  def fillOut
  end

  private

  def block_params
    params.require(:block).permit(:label)
  end
end
