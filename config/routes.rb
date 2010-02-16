ActionController::Routing::Routes.draw do |map|
  map.resources :keywords

  map.registration 'signup', :controller => 'users', :action => 'registration'
  map.finalize_registration 'signup/finalize', :controller => 'users', :action => 'finalize_registration'
  map.login 'signin', :controller => 'users', :action => 'login'
  map.finalize_login 'signin/finalize', :controller => 'users', :action => 'finalize_login'
  map.account 'profile', :controller => 'users', :action => 'profile'
  map.logout 'signout', :controller => 'users', :action => 'logout'

  map.finalize_project 'project/finalize', :controller => 'projects', :action => 'finalize'
  map.resources :projects, :member => {:followers => :get, :follows => :get, :keywords => :get, :ivents_graph => :get}

  map.root :controller => 'pages', :action => 'main'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
#== Route Map
# Generated on 16 Feb 2010 17:22
#
#              keywords GET    /keywords(.:format)                  {:action=>"index", :controller=>"keywords"}
#                       POST   /keywords(.:format)                  {:action=>"create", :controller=>"keywords"}
#           new_keyword GET    /keywords/new(.:format)              {:action=>"new", :controller=>"keywords"}
#          edit_keyword GET    /keywords/:id/edit(.:format)         {:action=>"edit", :controller=>"keywords"}
#               keyword GET    /keywords/:id(.:format)              {:action=>"show", :controller=>"keywords"}
#                       PUT    /keywords/:id(.:format)              {:action=>"update", :controller=>"keywords"}
#                       DELETE /keywords/:id(.:format)              {:action=>"destroy", :controller=>"keywords"}
#          registration        /signup                              {:action=>"registration", :controller=>"users"}
# finalize_registration        /signup/finalize                     {:action=>"finalize_registration", :controller=>"users"}
#                 login        /signin                              {:action=>"login", :controller=>"users"}
#        finalize_login        /signin/finalize                     {:action=>"finalize_login", :controller=>"users"}
#               account        /profile                             {:action=>"profile", :controller=>"users"}
#                logout        /signout                             {:action=>"logout", :controller=>"users"}
#      finalize_project        /project/finalize                    {:action=>"finalize", :controller=>"projects"}
#              projects GET    /projects(.:format)                  {:action=>"index", :controller=>"projects"}
#                       POST   /projects(.:format)                  {:action=>"create", :controller=>"projects"}
#           new_project GET    /projects/new(.:format)              {:action=>"new", :controller=>"projects"}
#          edit_project GET    /projects/:id/edit(.:format)         {:action=>"edit", :controller=>"projects"}
#      keywords_project GET    /projects/:id/keywords(.:format)     {:action=>"keywords", :controller=>"projects"}
#       follows_project GET    /projects/:id/follows(.:format)      {:action=>"follows", :controller=>"projects"}
#     followers_project GET    /projects/:id/followers(.:format)    {:action=>"followers", :controller=>"projects"}
#  ivents_graph_project GET    /projects/:id/ivents_graph(.:format) {:action=>"ivents_graph", :controller=>"projects"}
#               project GET    /projects/:id(.:format)              {:action=>"show", :controller=>"projects"}
#                       PUT    /projects/:id(.:format)              {:action=>"update", :controller=>"projects"}
#                       DELETE /projects/:id(.:format)              {:action=>"destroy", :controller=>"projects"}
#                  root        /                                    {:action=>"main", :controller=>"pages"}
#                              /:controller/:action/:id             
#                              /:controller/:action/:id(.:format)   
