require 'application'

class Pixelations::StylesheetsController < ApplicationController
  layout false

  def new
    @stylesheet = Stylesheet.new
  end

  def create
    @stylesheet = Stylesheet.create(params[:stylesheet])
    redirect_to pixelations_path(:stylesheet => @stylesheet.url_name)
  end

  def show
    @stylesheet = Stylesheet.find_by_url(params[:id])
    if @stylesheet
      respond_to do |wants|
        wants.sass { render :text => @stylesheet.sass }
        wants.css  { render :text => @stylesheet.css  }
      end
    else
      render_error_status(404)
    end
  end
end