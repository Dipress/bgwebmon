Bgwebmon::Application.routes.draw do

  root :to => "monitoring#index"

  match '/mon', :to => 'monitoring#index'
  match '/graph/:id', :to => 'monitoring#show'
  match '/dpupd', :to => 'monitoring#dpupdate'
  match '/errorlist/:id', :to => 'monitoring#errorlist'
  match '/cronrrd/:key', :to => 'rrdcron#datacreator'
  match '/checkonline/:key', :to => 'rrdcron#checkonline'
end
