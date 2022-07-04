require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  describe 'View all Category' do
    before do
      sign_in build(:user)
    end
      before { visit new_category_path }
  
      it 'show new page' do
        expect(page).to have_content 'Title'
        expect(page).to have_content 'Description'
        expect(page).to have_selector(:link_or_button, 'Create Category') 
      end
    
  end

  describe 'Fillup form and submit' do
      before do
        sign_in create(:user)
      end
      before { visit new_category_path }
  
      it 'submits the form' do
        within(all('form')[1]) do
          fill_in 'category_title', with: 'Example Title'
          fill_in 'category_description', with: 'Example description'
          expect{click_on 'Create Category'}.to change(Category, :count).by(1)
        end

      end
    
  end

  describe 'Edit a category' do 
    before do
      sign_in create(:user)
    end

    # category = Category.create!(title: "#{rand.to_s[1..9]} Category", description: "example description")
    
    let(:category) {Category.create!(title: "Edited Category", description: "example description")}
    
    before { visit "/categories/#{category.id}/edit" }

    it 'edits a category and submits the form' do
      within(all('form')[1]) do
        fill_in 'category_title', with: "New edited"
        fill_in 'category_description', with: "edited na example description"
        click_button('Update Category', exact: true)
      end
      
      edited_category = Category.find(category.id)
      expect(edited_category.title).to eq "New edited"
    end

  end

  

end
