require 'rails_helper'

RSpec.describe 'CategoriesControllers', type: :request do
  describe "GET /Categories/new" do
    before do
      sign_in build(:user)
    end
    it "returns the new page" do
      get "/categories/new"

      expect(response).to have_http_status(200)
    end
  end
  
  #POST Category
  describe "POST /Categories" do
    before do
      sign_in build(:user)
    end
    it "creates a new page" do
      expect { post "/categories", params: {category: {title: "New Category", description: "Fresh na fresh"}} }.to \
      change(Category, :count)
      .by(1)

      expect(response).to have_http_status(302)
    end
  end

  #EDIT Category
  describe "GET /Categories/1/edit" do
    before do
      sign_in build(:user)
    end
    it "returns the edit page" do
      category = Category.create!(title: "New Category", description: "Fresh na fresh")

      get "/categories/#{category.id}/edit"

      expect(response).to have_http_status(200)
    end
  end

  #Update Category
  describe "PATCH /Categories/1" do
    before do
      sign_in build(:user)
    end
    it "returns the edit page" do
      category = Category.create!(title: "New Category", description: "Fresh na fresh")

      patch "/categories/#{category.id}", params: {category: {title: "New edited", description: "edited na Fresh na fresh"}}

      edited_category = Category.find(category.id)
      expect(edited_category.title).to eq "New edited"
    end
  end

  #SHOW Category
  describe "GET /Categories/1" do
    it "returns the category details page" do
      category = Category.create!(title: "New Category", description: "Fresh na fresh")
      
      get "/categories/#{category.id}"

      # expect(response).to have_http_status(200)
    end
  end

end