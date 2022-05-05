class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      # redirect_to "/categories/new" 
      redirect_to categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      # redirect_to "/categories/new"
      redirect_to categories_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path
  end

  private
    def category_params
      params.require(:category).permit(:title, :description)
    end
end
