class WorksController < ApplicationController
  
  def index
    @works = Work.page(params[:page]).per_page(40)
  end
  
end
