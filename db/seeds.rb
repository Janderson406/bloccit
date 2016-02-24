# Create Users
5.times do
  User.create!(
# #3
  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
  post = Post.create!(
  #! instructs the method to raise error if there's a problem with data we're seeding.
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )

  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  #update the time a post was created. This makes our seeded data more realistic and will allow us to see our ranking algorithm
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
  #reate between one and five votes for each post. [-1, 1].sample randomly creates either an up vote or a down vote.

end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
#call sample on the array returned by Post.all,
#in order to pick a random post to associate each comment with
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

user = User.first
 user.update_attributes!(
   email: 'jondanderson@gmail.com', # replace this with your personal email
   password: 'helloworld'
 )

 # Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
