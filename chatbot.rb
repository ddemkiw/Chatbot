
load './RESPONSES.rb' 
load './colours.rb'


def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? new_chat? : response % { c1: $1, c2: $2, c3: $3, c4: $4}
end

def intro
    puts chatbot("Hello, what\'s your name?")
    @name = gets.chomp
    puts @name=="quit" ? quit : chatbot("Hello #{@name}"); user  
end

def chat
    while(input = gets.chomp) do
      puts input=="quit" ? quit : chatbot(get_response(input.downcase)); user
    end
end


def new_chat?
  puts chatbot("I don't have any current chatters saved on that subject. Would you like me to add that subject? yes/no")
  input = gets.chomp
    if input == "yes" 
      get_new_chat
      elsif input == "quit"
      quit 
      else chatbot('Ok. Let\'s chat about something else')
    end
end

def get_new_chat
  puts chatbot("input chatter>>"); user
    key = gets.chomp
  puts chatbot("input chatbot response>>"); user
    value = gets.chomp
  hash2 = {key.downcase => value}
  RESPONSES.merge!(hash2)
  save_response
  return "got it"
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
  puts chatbot("Goodbye!")
  exit!
end

intro 
chat 