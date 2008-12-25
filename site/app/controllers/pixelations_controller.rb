require 'application'

class PixelationsController < ApplicationController
  SASS_ENGINE_OPTS = {
    :load_paths => Compass::Frameworks::ALL.map{|f| f.stylesheets_directory}
  }
  def show
    @width = 100
    @height = 100
    @stylesheet = Stylesheet.find_by_url(params[:stylesheet]) if params[:stylesheet]
    @alternate_stylesheets = Stylesheet.all
    @stylesheet ||= @alternate_stylesheets[rand(@alternate_stylesheets.size)]
    @alternate_stylesheets -= [@stylesheet]
  end
  def render_stylesheet
    @sass = params[:sass]
    begin
      @css = Sass::Engine.new(@sass, SASS_ENGINE_OPTS).render
      render :text => @css, :layout => false
    rescue Sass::SyntaxError => e
      render :text => e.message, :status => 400, :layout => false
    end
  end
end