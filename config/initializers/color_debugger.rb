class Object
  def cdebug(tag=nil)
    RAILS_DEFAULT_LOGGER.info "\n\033[1;33;44m#{tag}\033[1;32;40m#{self.class} \033[0;30;47m#{self.inspect}\033[0m"
  end
  def prepare_dump(tag=nil)
    @stack = []
    @stack << "\n\033[1;33;44m#{tag}\033[1;32;44m #{self.class}\033[0m\n"
    if self.class == Class
      @stack << "\033[1;34;47mMethods\033[0m\n"
      self.methods.sort.each{|m|@stack << "\t\033[1;36;40m#{m}\033[0m\n"}
    end
    if self.methods.include?('each_key')
      @stack << "\033[1;34;47mPairs\033[0m\n"
      self.each_key{|k|@stack << "\t\033[0;32;40m#{k} => \t\t\033[0;37;40m#{self[k].inspect}\033[0m\n"}
    end
    if self.methods.include?('each_index')
      @stack << "\033[1;34;47mValues\033[0m\n"
      self.each_index{|k|@stack << "\t\033[0;32;40m#{k}:\t\t\033[0;37;40m#{self[k].inspect}\033[0m\n"}
    end
    if self.methods.include?('attributes')
      @stack << "\033[1;34;47mAttributes\033[0m\n"
      self.attribute_names.sort.each{|a|@stack << "\t\033[0;35;40m#{a}:\t\t\033[0;37;40m#{self.send(a).inspect}\033[0m\n"}
    end
    @stack
  end

  def cdump(tag=nil)
    RAILS_DEFAULT_LOGGER.info self.prepare_dump(tag).join("\n")
    @stack = []
  end

  def cputs(tag=nil)
    puts self.prepare_dump(tag).join(' ')
    @stack = []
    nil
  end
end