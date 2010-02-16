class ProjectsController < ApplicationController
  include OpenFlashChart

  before_filter :find_project

  PROJECTS_PER_PAGE = 20

  def new
    oauth.set_callback_url(finalize_project_url)
    
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    
    redirect_to oauth.request_token.authorize_url
  end

  def finalize
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    
    session['rtoken']  = nil
    session['rsecret'] = nil

    profile = Twitter::Base.new(oauth).verify_credentials
    project = Project.create({
      :user_id => current_user.id,
      :atoken => oauth.access_token.token, 
      :asecret => oauth.access_token.secret,
      :name => profile.screen_name,
      :twitter_uid => profile.id,
      :avatar_url => profile.profile_image_url
    })
    notice('Project created')
    redirect_to root_path
  end

  def destroy
    respond_to do |format|
      if @project.destroy
        flash[:notice] = 'Project was successfully destroyed.'        
        format.html { redirect_to projects_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Project could not be destroyed.'
        format.html { redirect_to @project }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @projects = current_user.projects.paginate(:page => params[:page], :per_page => PROJECTS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @projects }
    end
  end

  def edit
  end

  def followers
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def follows
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def keywords
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def ivents_graph
    chart = Chart.new()
    chart.title = Title.new(:text => "#{@project.name} activity")
    offset = params[:offset].to_i
    case params[:unit]
    when 'day'
      start_date = Date.today() - (1 + offset).day
      end_date = Date.today() - offset.day
      step = 1.hour
    when 'year'
      start_date = Date.today() - (1 + offset).year
      end_date = Date.today() - offset.year
      step = 7.days
    else
      start_date = Date.today() - (1 + offset).month
      end_date = Date.today() - offset.month
      step = 1.day
    end
    retweets_bar = Area.new(:text => 'Retweets')
    retweets_bar.tip = 'Retweets: #val#'
    follows_bar = Area.new(:text => 'Follows')
    follows_bar.tip = 'Follows: #val#'
    limits_bar = Area.new(:text => 'Limits')
    limits_bar.tip = 'Limits: #val#'
    @x_max = @y_max = 0

    @x_labels = XAxisLabels.new(:rotate => -90)
    while start_date < end_date
      start_date += step
      @x_labels << {:text => I18n::l(start_date, :format => :short)}
      # retweets
      amount = @project.count_ivents(start_date, start_date + step, 'retweet')
      @x_max = amount if amount > @x_max.to_i
      retweets_bar << amount
      # follows
      amount = @project.count_ivents(start_date, start_date + step, 'follow')
      @x_max = amount if amount > @x_max.to_i
      follows_bar << amount
      # limits
      amount = @project.count_ivents(start_date, start_date + step, 'limit')
      @x_max = amount if amount > @x_max.to_i
      limits_bar << amount
      @y_max = @y_max.to_i + 1
    end
    
    chart << retweets_bar
    chart << follows_bar
    chart << limits_bar
    
    chart.y_axis = YAxis.new({
      :steps => @x_max/15,
      :min => 0,
      :max => (@x_max + @x_max/10)
    })
    x_axis = XAxis.new(:max => @y_max)
    x_axis.labels = @x_labels
    chart.x_axis = x_axis
    render :text => chart
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to @project }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def oauth
    @oauth ||= Twitter::OAuth.new(APP_CONFIG[:consumer_key], APP_CONFIG[:consumer_secret])
  end

  def find_project
    @project = Project.find(params[:id]) if params[:id]
  end

end