require 'application'

class HighlightController < ApplicationController

  def show
    @filename = params[:file].join('/')
    full_path = "#{RAILS_ROOT}/public/highlighted/stylesheets/#{@filename}.html"
    if File.exists? full_path
      @contents = File.open(full_path) {|f| f.read }
    else
      render_error_status(404)
    end
  end
end