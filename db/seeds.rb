# Create Posts
50.times do
  Post.create!(
  #! instructs the method to raise error if there's a problem with data we're seeding.
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
#call sample on the array returned by Post.all,
#in order to pick a random post to associate each comment with
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

Post.find_or_create_by(title: "Unique Title!!", body: "And a unique body to go with it!")
Comment.find_or_create_by(body: "UNIQUE COMMENT!!")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
