class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = "Great! Your kitten has been created!"
      redirect_to @kitten
    else
      flash.now[:error] = "Something went wrong! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = "Great! Your kitten has been updated!"
      redirect_to @kitten
    else
      flash.now[:error] = "Something went wrong! Fix your mistakes, please."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    flash[:notice] = "You have killed your kitten. You monster!"
    redirect_to root_path, status: :see_other
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
