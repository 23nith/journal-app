class TasksController < ApplicationController
  before_action :get_category
  # before_action :authenticate_user!, except: %i[ index]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  def index
    if params[:category_id].present?
      @tasks = @category.tasks
    else
      # @tasks = Task.all
      @tasks = Task.order(params[:sort])
    end
  end

  def show
    if params[:category_id].present?
      @task = @category.tasks.find(params[:id])
    else
      # @task = Task.find(params[:id])
      @task = Task.find(params[:id])
    end
  end

  def new
    if params[:category_id].present?
      @task = @category.tasks.build
    else
      @task = Task.new(task_params)
    end
    @categories = Category.all
  end

  def edit
    if @category == nil
      @task = Task.find(params[:id])
    else
      @task = @category.tasks.find(params[:id])
    end
    @categories = Category.all
  end

  def create
    @categories = Category.all
    if @category == nil
      @task = Task.new(task_params)
    else
      @task = @category.tasks.build(task_params)
    end
    if @task.save!
      # redirect_to category_tasks_path
      # redirect_to category_path(@category.id)
      if params[:category_id].present?
        redirect_to category_path(@category.id)
      else
        redirect_to tasks_path
      end
    else
      render :new
    end
  end

  def update
    if params[:category_id].present?
      @task = @category.tasks.find(params[:id])
    else
      @task = Task.find(params[:id])
    end

    if @task.update(task_params)
      if params[:category_id].present?
        redirect_to category_path(@category.id)
      else
        redirect_to tasks_path
      end
    end
  end

  def destroy 
    if params[:category_id].present?
      @task = @category.tasks.find(params[:id])
    else
      @task = Task.find(params[:id])
    end
    @task.destroy
    if params[:category_id].present?
      redirect_to category_path(@category.id)
    else
      redirect_to tasks_path
    end
  end

  private

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_path, notice: "You are not authorized to access that task" if @task.nil?
  end  
  
  def get_category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    else
      @category = nil
    end
  end

  def task_params
    if params[:task].present?
      params.require(:task).permit(:id, :name, :body, :category_id, :user_id)
    else
      params.permit(:id, :name, :body, :category_id, :user_id)
    end
  end
end
