class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy   #add dependent:destroy so that all dependent posts, comments, and votes are destroyed when their parent user is deleted
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

   before_save { self.email = email.downcase }
   before_save { self.role ||= :member } #shorthand for self.role = :member if self.role.nil?
   #inline callback: trigger logic before/after an alteration of the object state

   before_create :generate_auth_token
   #use the before_create hook to ensure that a token is generated for a user before it is created and saved to the database.

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
     #has_secure_password "adds methods to set and authenticate against a BCrypt password.
     #This mechanism requires you to have a password_digest attribute."
     #This function abstracts away much of the complexity dealing with sophisticated encryption
     #algorithms we would have to write to securely save passwords.
     #has_secure_password requires a password_digest attribute on the model it is applied to.
     #has_secure_password creates two virtual attributes, password and password_confirmation that we use to set and save the password.

   enum role: [:member, :admin]

   def favorite_for(post)
     favorites.where(post_id: post.id).first
   end
   #this takes a post object and uses where to retrieve the user's favorites with a post_id
   #that matches post.id. If the user has favorited post it will return an array of one item.
   #If they haven't favorited post it will return an empty array. Calling first on the array
   #will return either the favorite or nil depending on whether they favorited the post.

   def avatar_url(size)
     gravatar_id = Digest::MD5::hexdigest(self.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end

   def generate_auth_token
     loop do
       self.auth_token = SecureRandom.base64(64)
       break unless User.find_by(auth_token: auth_token)
     end
   end
    # generate_auth_token uses SecureRandom.base64(n) to generate a Base64 string. The argument n
    #specifies the length, in bytes, of the random number to be generated.



end
