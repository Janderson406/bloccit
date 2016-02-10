class SessionsController < ApplicationController
  def new
  end

  def create
  #search the database for a user with the specified email address in the params hash.
  #We use downcase to normalize the email address since the addresses stored in the database are stored as lowercase strings
    user = User.find_by(email: params[:session][:email].downcase)

  #verify that user is not nil and that the password in the params hash matches the specified password
    if user && user.authenticate(params[:session][:password])
      create_session(user) #definfed in helpers/sessions_helper.rb
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
  #This method will delete a user's session. destroy logs the user out by calling destroy_session(current_user)
    destroy_session(current_user) #definfed in helpers/sessions_helper.rb
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
