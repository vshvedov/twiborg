class KeywordsController < ApplicationController

  before_filter :find_keyword

  def create
    @keyword = Keyword.new(params[:keyword])
    respond_to do |format|
      if @keyword.save
        flash[:notice] = 'Keyword was successfully created.'
        format.html { redirect_to keywords_project_url(@keyword.project) }
        format.xml  { render :xml => @keyword, :status => :created, :location => @keyword }
      else
        error('Can`t create')
        @keyword.errors.each{|e| error('<br />'+e.join(" "))}
        format.html { redirect_to keywords_project_url(@keyword.project) }
        format.xml  { render :xml => @keyword.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @keyword.destroy
        flash[:notice] = 'Keyword was successfully destroyed.'        
        format.html { redirect_to keywords_project_url(@keyword.project) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Keyword could not be destroyed.'
        format.html { redirect_to keywords_project_url(@keyword.project) }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  private

  def find_keyword
    @keyword = Keyword.find(params[:id]) if params[:id]
  end

end