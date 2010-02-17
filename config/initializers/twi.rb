class Twi < Twitter::Base
  def user id
    puts "Twi.user\t\t#{id}"
    super
  end

  def update text
    puts "Twi.update\t\t#{text}"
    super
  end

  def friendship_exists? a, b
    puts "Twi.friendship_exists?\t\t#{a}\t#{b}"
    super
  end
end