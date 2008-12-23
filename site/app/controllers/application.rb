# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'dc65e92c20b7c9407aad3f61541ef0e6'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  # send a default error status code as a response. If
  # a file exists for that status, serve it.
  def render_error_status(status = 500, options = {})
    file = (f = options[:file]) ? "#{RAILS_ROOT}/public/#{f}" : "#{RAILS_ROOT}/public/#{status}.html"
    if File.exists?(file)
      render :file => file, :status => status
    else
      render :text => status, :status => status
    end
  end
end
