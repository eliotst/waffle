class BlocksController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def new
  	@block = Block.new
  end

  def create
  	@block = Block.new(block_params)
  	if @block.save
  	  flash[:notice] = "Block created succesfully."
  	  redirect_to blocks_path
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

  def update
  	@block = Block.find(params[:id])
    if not current_user.admin?
      @particiant = current_user.participant
    end
    if @block.update_attributes(block_params)
      redirect_to @block, notice: "Block updated!"
    else
      render 'edit'
    end
  end

  def index
  	@blocks = Block.paginate(page: params[:page])
  end

  def destroy
    Block.find(params[:id]).destroy
    flash[:success] = "Block deleted."
    redirect_to blocks_path
  end

  private
  def block_params
    params.require(:block).permit(:label)
  end
end
