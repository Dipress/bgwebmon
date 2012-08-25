Bgwebmon::Application.routes.draw do
  
  root :to => "monitoring#index"

  match '/mon', :to => 'monitoring#index'
  match '/graph/:id', :to => 'monitoring#show'
  match '/dpupd', :to => 'monitoring#dpupdate'
  
end
