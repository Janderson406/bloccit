module SessionsHelper
  #create_session sets user_id on the session object to user.id, which is unique for each user.
  #session is an object Rails provides to track the state of a particular user.
  #There is a one-to-one relationship between session objects and user ids
  #session object can only have one user id and a user id is related to one session object.
   def create_session(user)
     session[:user_id] = user.id
   end

 #clear the user id on the session object by setting it to nil
   def destroy_session(user)
     session[:user_id] = nil
   end

 #current_user returns current user of the application.  Thus we won't have to constantly call User.find_by(id: session[:user_id])
 #Because our session only stores the user id, we need to retrieve the User instance,
 #and all of its properties, by searching the database for the record with the corresponding user id.
   def current_user
     User.find_by(id: session[:user_id])
   end
end


#### SessionsController has no way of finding create_session - it won't recognize it as a valid method.
#### We need to include SessionsHelper either directly in SessionsController, or in ApplicationController
#### add it to ApplicationController, since we'll need to use it in other controllers later
