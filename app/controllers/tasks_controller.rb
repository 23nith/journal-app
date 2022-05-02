class TasksController < ApplicationController
  before_action :get_category

  def index
    @tasks = @category.tasks
  end

  def show
    @task = @category.tasks.find(params[:id])
  end

  def new
    @task = @category.tasks.build
  end

  def edit
    @task = @category.tasks.find(params[:id])
  end

  def create
    @task = @category.tasks.build(task_params)
    if @task.save
      # redirect_to category_tasks_path
      redirect_to category_path(@category.id)
    else
      render :new
    end
  end

  def update
    @task = @category.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to category_path(@category.id)
    end
  end

  def destroy 
    @task = @category.tasks.find(params[:id])
    @task.destroy
    redirect_to category_path(@category.id)
  end

  private
  
  def get_category
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:body, :category_id)
  end
end
