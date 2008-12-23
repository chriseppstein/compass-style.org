ActionController::Routing::Routes.draw do |map|
  map.highlight "hl/*file", :controller => "highlight", :action => 'show'
  map.root :controller => "home"
end
