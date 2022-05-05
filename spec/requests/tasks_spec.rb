require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end

  describe "GET /tasks/new" do
    before do
      sign_in build(:user)
    end
    it "returns the new page" do
      get "/tasks/new"

      expect(response).to have_http_status(200)
    end
  end
  
  #POST Task
  describe "POST /tasks" do
    before do
      @user = create(:user)
      sign_in @user
      @category = Category.create!(title: "Edited Category", description: "example description")
    end
    it "creates a new page" do
      expect { post "/tasks", params: {task: {name: "New Task", body: "Fresh na fresh", category_id: @category.id, user_id: @user.id }} }.to \
      change(Task, :count)
      .by(1)

      expect(response).to have_http_status(302)
    end
  end

  #EDIT Task
  describe "GET /tasks/1/edit" do
    before do
      @user = create(:user)
      sign_in @user
      @category = Category.create!(title: "Edited Category", description: "example description")
    end
    it "returns the edit page" do
      task = Task.create!(body: "New Category", body: "Fresh na fresh", category: @category, user: @user)

      get "/tasks/#{task.id}/edit"

      expect(response).to have_http_status(200)
    end
  end

  #Update Task
  describe "PATCH /tasks/1" do
    before do
      @user = create(:user)
      sign_in @user
      @category = Category.create!(title: "Edited Category", description: "example description")
    end
    it "returns the edit page" do
      task = Task.create!(name: "New Category", body: "Fresh na fresh", category: @category, user: @user)

      patch "/tasks/#{task.id}", params: {task: {name: "New edited", body: "edited na Fresh na fresh", category_id: @category.id, user_id: @user.id}}

      edited_task = Task.find(task.id)
      expect(edited_task.name).to eq "New edited"
    end
  end

  #SHOW Task
  describe "GET /tasks/1" do
    before do
      @user = create(:user)
      sign_in @user
      @category = Category.create!(title: "Edited Category", description: "example description")
    end
    it "returns the task details page" do
      task = Task.create!(name: "New Category", body: "Fresh na fresh", category: @category, user: @user)
      
      get "/tasks/#{task.id}"

      expect(response).to have_http_status(200)
    end
  end
end
