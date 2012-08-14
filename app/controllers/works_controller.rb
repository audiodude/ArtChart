class WorksController < ApplicationController
  
  def index
    @works = Work.page(params[:page]).per_page(40)
  end

  def search
    @works = Work.search(params['q'], :page => params[:page], :per_page => 40)
    render :action => :index
  end
  
end
