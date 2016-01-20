Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/contact'

  root 'welcome#index'
  #root method allows us to declare the default page the app loads when we navigate to the home page URL.
  #root is a method that takes a hash as an argument

end
