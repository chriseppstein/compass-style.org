class Rails::InstallersController < ApplicationController
  def show
    redirect_to "http://github.com/chriseppstein/compass/raw/master/lib/compass/app_integration/rails/templates/compass-install-rails.rb"
  end
end