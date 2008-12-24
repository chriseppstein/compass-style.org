ActionController::Routing::Routes.draw do |map|
  map.resource :pixelations
  map.namespace :pixelations do |pixelations|
    pixelations.resources :stylesheets
  end
  map.highlight "hl/*file", :controller => "highlight", :action => 'show'
  map.root :controller => "home"
end
