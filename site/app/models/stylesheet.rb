class Stylesheet < ActiveRecord::Base
  acts_as_url_param

  before_validation :generate_css

  validates_presence_of :css, :on => :create, :message => "can't be blank"

  protected

  def sass_engine_opts
    Compass.configuration.to_sass_engine_options
  end

  def generate_css
    self.css = Sass::Engine.new(self.sass, sass_engine_opts).render
  end

end