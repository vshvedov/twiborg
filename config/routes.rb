ActionController::Routing::Routes.draw do |map|
  map.resources :keywords

  map.registration 'signup', :controller => 'users', :action => 'registration'
  map.finalize_registration 'signup/finalize', :controller => 'users', :action => 'finalize_registration'
  map.login 'signin', :controller => 'users', :action => 'login'
  map.finalize_login 'signin/finalize', :controller => 'users', :action => 'finalize_login'
  map.account 'profile', :controller => 'users', :action => 'profile'
  map.logout 'signout', :controller => 'users', :action => 'logout'

  map.finalize_project 'project/finalize', :controller => 'projects', :action => 'finalize'
  map.resources :projects, :member => {:followers => :get, :follows => :get, :keywords => :get}

  map.root :controller => 'pages', :action => 'main'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
