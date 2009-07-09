require 'compass'

Compass.configuration do |config|
  config.project_path = RAILS_ROOT
  config.sass_dir = 'app/stylesheets'
  config.css_dir = 'public/stylesheets'
  config.images_dir = 'public/images'
  config.http_path = '/'
  config.http_images_path = "/images"
end

Compass.configure_sass_plugin!
