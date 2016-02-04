class User < ActiveRecord::Base

   before_save { self.email = email.downcase }
   #inline callback: trigger logic before/after an alteration of the object state
   EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   #The character pattern that we set EMAIL_REGEX to defines what constitutes a valid email address.

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  # ensure that name is present and has a maximum and minimum length.
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  #executes if password_digest is nil. This ensures that when we create a new user, they have a valid password.
  validates :password, length: { minimum: 6 }, allow_blank: true
  #when updating pw, new password is also 6 char's long. allow_blank: true skips validation if no updated password is given.
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 100 },
             format: { with: EMAIL_REGEX }

   has_secure_password
end
    #has_secure_password "adds methods to set and authenticate against a BCrypt password.
    #This mechanism requires you to have a password_digest attribute."
    #This function abstracts away much of the complexity dealing with sophisticated encryption
    #algorithms we would have to write to securely save passwords.
    #has_secure_password requires a password_digest attribute on the model it is applied to.
    #has_secure_password creates two virtual attributes, password and password_confirmation that we use to set and save the password.
