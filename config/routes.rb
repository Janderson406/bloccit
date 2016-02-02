Rails.application.routes.draw do

  resources :questions 
  #get 'posts/index'
  #get 'posts/show'
  #get 'posts/new'
  #get 'posts/edit'
#==> REFACTORED TO:
  resources :posts
    #instructs Rails to create post routes for creating, updating,
    #viewing, and deleting instances of Post

  #get 'welcome/index'
  #get 'welcome/about'
#==> REFACTORED TO:
  get 'about' => 'welcome#about'
  #1. remove get "welcome/index" b/c we've declared index view as the root view
  #2. modify about route; allows users to visit /about, rather than /welcome/about


  root 'welcome#index'
  #root method allows us to declare the default page the app loads when we navigate to the home page URL.
  #root is a method that takes a hash as an argument

end
