class Twi < Twitter::Base
  def user id
    log_message "Twi.user\t\t#{id}"
    super
  end

  def update text
    log_message "Twi.update\t\t#{text}"
    super
  end

  def friendship_exists? a, b
    log_message "Twi.friendship_exists?\t\t#{a}\t#{b}"
    super
  end

  def friendship_create screen_name, follow
    log_message "Twi.start_follow\t\t#{screen_name}"
    super
  end

  def followers
    log_message "Twi.followers"
    super
  end

  def friends
    log_message "Twi.friends"
    super
  end


  def log_message mes
    puts "\033[1;33;44m#{mes}\033[0m"
    RAILS_DEFAULT_LOGGER.info "\033[1;33;44m#{mes}\033[0m" unless RAILS_DEFAULT_LOGGER.nil?
  end
end