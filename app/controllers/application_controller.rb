# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem

private
  def oauth auto = false
    @oauth ||= Twitter::OAuth.new(APP_CONFIG[:consumer_key], APP_CONFIG[:consumer_secret], :sign_in => auto)
  end

  def error(mes)
    flash[:error] = '' if flash[:error].nil?
    flash[:error] << mes
  end

  def notice(mes)
    flash[:notice] = '' if flash[:notice].nil?
    flash[:notice] << mes
  end

  def warn(mes)
    flash[:warning] = '' if flash[:notice].nil?
    flash[:warning] << mes
  end
end
