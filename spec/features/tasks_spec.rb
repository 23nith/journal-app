require 'rails_helper'

RSpec.describe 'Tasks', type: :feature do
  describe 'View all Task' do
      before do
        sign_in create(:user)
      end
      before { visit new_task_path }
  
      it 'show new page' do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Body'
        expect(page).to have_selector(:link_or_button, 'Create Task') 
      end
    
  end

  describe 'Fillup form and submit' do
      before do
        sign_in create(:user)
        Category.create!(title: "Edited Category", description: "example description")
      end
      before { visit new_task_path }
  
      it 'submits the form' do
        within(all('form')[1]) do
          fill_in 'task_name', with: 'Example name'
          fill_in 'task_body', with: 'Example body'
          select("Edited Category", from: "task_category_id").select_option
          expect{click_on 'Create Task'}.to change(Task, :count).by(1)
        end

      end
    
  end

  describe 'Edit a task' do 
    before do
      @user = create(:user)
      sign_in @user
      @category = Category.create!(title: "Edited Category", description: "example description")
    end
    
    let(:task) {Task.create!(name: "Edited Task", body: "example description", category: @category, user: @user)}
    
    before { visit "/tasks/#{task.id}/edit" }

    it 'edits a task and submits the form' do
      within(all('form')[1]) do
        fill_in 'task_name', with: "New edited"
        fill_in 'task_body', with: "edited na example description"
        select("Edited Category", from: "task_category_id").select_option
        click_button('Update Task', exact: true)
      end
      
      edited_task = Task.find(task.id)
      expect(edited_task.name).to eq "New edited"
    end

  end

  

end
