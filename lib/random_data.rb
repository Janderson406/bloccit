module RandomData
 #define as module because it's a standalone library w/ no dependencies/inheritance requirements
   def self.random_paragraph
     sentences = []
     rand(4..6).times do
       sentences << random_sentence
     end
     #join combines each sentence into a full paragraph (as a string).
     sentences.join(" ")
   end


   def self.random_sentence
     strings = []
     rand(3..8).times do
       strings << random_word
     end

     sentence = strings.join(" ")
     sentence.capitalize << "."
     #capitalize returns a copy of sentence with the first character
     #converted to uppercase and the remainder of the sentence converted to lowercase
   end


   def self.random_word
     letters = ('a'..'z').to_a #set letters to an array
     letters.shuffle!
     #call shuffle! on letters in place. If we were to call shuffle without the bang (!)
     #then shuffle would return an array rather than shuffle in place
     letters[0,rand(3..8)].join #join the zeroth through nth item in letters
                #The nth item is the result of rand(3..8)
   end

   def self.random_name
     first_name = random_word.capitalize
     last_name = random_word.capitalize
     "#{first_name} #{last_name}"
   end


   def self.random_email
     "#{random_word}@#{random_word}.#{random_word}"
   end

 end
