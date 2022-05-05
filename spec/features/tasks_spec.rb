require 'rails_helper'

RSpec.describe 'Tasks', type: :feature do
  describe 'View all Task' do
      before { visit new_task_path }
  
      it 'show new page' do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Body'
        expect(page).to have_selector(:link_or_button, 'Create Task') 
      end
    
  end

  describe 'Fillup form and submit' do
      before { visit new_task_path }
  
      it 'submits the form' do
        within 'form' do
          fill_in 'task_name', with: 'Example name'
          fill_in 'task_body', with: 'Example body'
          expect{click_on 'Create Task'}.to change(Task, :count).by(1)
        end

        # expect(page).to have_selector(:link_or_button, 'Create Category') 
      end
    
  end

  describe 'Edit a task' do 

    
    let(:task) {Task.create!(title: "Edited Task", description: "example description")}
    
    before { visit "/tasks/#{task.id}/edit" }

    it 'edits a task and submits the form' do
      within 'form' do
        fill_in 'task_title', with: "New edited"
        fill_in 'task_description', with: "edited na example description"
        # click_on 'Update Task'
        click_button('Update Task', exact: true)
      end
      
      edited_task = Task.find(task.id)
      expect(edited_task.title).to eq "New edited"
      # expect(page).to have_selector(:link_or_button, 'Create Category')
    end

  end

  

end
