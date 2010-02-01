class Object
  def cdebug(tag=nil)
    RAILS_DEFAULT_LOGGER.info "\n\033[1;33;44m#{tag}\033[1;32;40m #{self.class} \033[0;30;47m#{self.inspect}\033[0m"
  end
end