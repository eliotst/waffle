class BlocksController < ApplicationController
  def new
  	@block = Block.new
  	3.times do |n|
  	  question = @block.questions.build 
  	  1.times do |n|
  	    question.answers.build
  	  end
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
    params.require(:block).permit(:label, questions_attributes: 
      [:label, :text, :id, :_destroy, answers_attributes: 
      [:value, :id, :participant_id,:_destroy], choices_attributes:
      [:value, :id, :_destroy]])
  end
end
