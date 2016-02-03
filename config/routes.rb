Rails.application.routes.draw do

  #get 'posts/index'
  #get 'posts/show'
  #get 'posts/new'
  #get 'posts/edit'
#==> REFACTORED TO:
#resource instructs Rails to create routes for creating, updating, viewing, and deleting instances
resources :topics do
   resources :posts, except: [:index]
   resources :sponsored_posts, except: [:index]
 end
  #^^ we pass resources :posts to the resources :topics block. This nests the post routes under the topic routes.
  #posts index view is no longer needed. All posts will be displayed with respect to a topic now, on the topics show view



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
