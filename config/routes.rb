Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "categories#index"

  get '/categories' => 'categories#index'

  get 'categories/:id' => "categories#show", as: "category", id: /\d+/

  get 'categories/new' => "categories#new", as: "new_category"
  post '/categories' => "categories#create", as: "create_category"

  get '/categories/:id/edit' => "categories#edit", as: "edit_category"
  patch '/categories/:id' => "categories#update", as: "update_category"

  delete 'categories/:id', to: 'categories#destroy', as: 'delete_category'

  resources :categories do
    resources :tasks
  end

end
 