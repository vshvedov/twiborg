class UserSession < Authlogic::Session::Base
  def self.oauth_consumer
    OAuth::Consumer.new("PwVJaajHnZnRjDtt5FgmHA", "CVomRTGyJ6UiGieNAMSI5vWNlhcOqtp8iaXVuG4TGw", { :site=>"http://twitter.com", :authorize_url => "https://twitter.com/oauth/authorize" })
  end
end