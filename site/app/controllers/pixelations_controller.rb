class PixelationsController < ApplicationController
  def show
    @width = 100
    @height = 100
    @stylesheet = Stylesheet.find_by_url(params[:stylesheet]) if params[:stylesheet]
    @alternate_stylesheets = Stylesheet.all
    @stylesheet ||= @alternate_stylesheets[rand(@alternate_stylesheets.size)]
    @alternate_stylesheets -= [@stylesheet]
  end
end