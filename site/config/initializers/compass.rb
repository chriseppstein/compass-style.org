require 'compass'
# If you have any compass plugins, require them here.
Sass::Plugin.options[:template_location] = {
  "#{RAILS_ROOT}/app/stylesheets" => "#{RAILS_ROOT}/public/stylesheets"
}
Compass::Frameworks::ALL.each do |framework|
  Sass::Plugin.options[:template_location][framework.stylesheets_directory] = "#{RAILS_ROOT}/public/stylesheets"
end
