class HomeController < ApplicationController
  before_filter :authenticate_user! ,:except => ["index","getjson"]
  skip_before_filter :verify_authenticity_token

  def index
    #@data = Page.all
  #  @data = JSON.parse("abc").to_json
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def getjson   
     if user_signed_in?
      r = '{"a":1}';
     else
      r = '{"a":0}';
     end
     respond_to do |f|
       f.json { render json: r, :callback => params[:callback] }
     end
  end

  def report_problem
  end
end
