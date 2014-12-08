
load './RESPONSES.rb' 
load './colours.rb'


def intro
    puts chatbot("Hello, what\'s your name?")
    @name = gets.chomp
    puts @name=="quit" ? quit : chatbot("Hello #{@name}"); user  
  end

  def chat
    while(input = gets.chomp) do
      puts input=="quit" ? quit : chatbot(get_response(input.downcase)) ; user
    end
  end

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? new_chat : response % { c1: $1, c2: $2, c3: $3, c4: $4}
end


def new_chat
    puts "I don't have any current chatters saved on that subject. 
  Would you like me to add that subject? yes/no".red
  input = gets.chomp
   if input == "yes" 
    puts chatbot("input chatter>>")
    key = gets.chomp
    puts chatbot("input chatbot response>>")
    value = gets.chomp

    hash2 = {key.downcase => value}

    RESPONSES.merge!(hash2)
    save_response

  


elsif input == "quit"
      quit 
    else chatbot('Ok. Let\'s chat about something else')
  end
end


def save_response 
    target = open("RESPONSES.rb", 'w')
    target.write("RESPONSES = " + RESPONSES.to_s)
    target.close
end


def chatbot(i)
  print "Chatbot>> #{i}".red 
end

def user
  print "#{@name}>> "
end

def quit
  puts "Goodbye!".red
  exit!
end

intro 
chat 