class UsersController < ApplicationController
  # before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show]

  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = "Account registered!"
        redirect_back_or_default account_url
      else
        @user.errors.each{|e| error(e.join(' '))}
        redirect_back_or_default root_path
      end
    end
  end

  def show
    @user = @current_user
  end
end
