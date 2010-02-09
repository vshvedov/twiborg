class ProjectsController < ApplicationController

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