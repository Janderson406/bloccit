Rails.application.routes.draw do

  resources :labels, only: [:show]

  #get 'posts/index'
  #get 'posts/show'
  #get 'posts/new'
  #get 'posts/edit'
#==> REFACTORED TO:
#resource instructs Rails to create routes for creating, updating, viewing, and deleting instances
  resources :topics do
     resources :posts, except: [:index]
   end
  #^^ we pass resources :posts to the resources :topics block. This nests the post routes under the topic routes.
  #posts index view is no longer needed. All posts will be displayed with respect to a topic now, on the topics show view
  resources :posts, only: [] do
   # " only: [] " because we don't want to create any /posts/:id routes, just posts/:post_id/comments
    resources :comments, only: [:create, :destroy]
    # We'll display comments on the posts show view, so we won't need index or new
    resources :favorites, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
    #These new lines create POST routes at the URL posts/:id/up-vote and posts/:id/down-vote.
    #The as key-value pairs at the end stipulate the method names which will be associated with theese routes: up_vote_path and down_vote_path.
  end


  resources :users, only: [:new, :create, :show]
  #'only' hash key will prevent Rails from creating unnecessary routes.

  resources :sessions, only: [:new, :create, :destroy]

  #get 'welcome/index'
  #get 'welcome/about'
#==> REFACTORED TO:
  get 'about' => 'welcome#about'
  #1. remove get "welcome/index" b/c we've declared index view as the root view
  #2. modify about route; allows users to visit /about, rather than /welcome/about


  root 'welcome#index'
  #root method allows us to declare the default page the app loads when we navigate to the home page URL.
  #root is a method that takes a hash as an argument

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]
      resources :topics, except: [:edit, :new]
    end
  end
  # v1 is nested under api to create a URI of /api/v1/
  # Under our nested namespace we see resourceful routing for users & topics, with only an index and show route.
  # We now have two new URIs: /api/v1/users and /api/v1/users/id, which correspond to the index and show actions respectively
end
