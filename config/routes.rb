Bgwebmon::Application.routes.draw do

  resources :sessions do
    collection do 
      get :new
      post :create
      delete :destroy
    end
  end

  resources :tasks

  root :to => "menu#index"

  match '/taskcommentnew', :to => 'tasks#commentcreate'
  match '/taketask/:id', :to => 'tasks#take'
  match '/deletetcomment/:id', :to => "tasks#deletetcomment"
  match '/tstatuschange/:id' => "tasks#tstatuschange"
  match '/tstatuschangeopen/:id' => "tasks#tstatuschangeopen"

  match '/docs', :to => 'docs#index'
  match '/doc/:title(/:query)', :to => 'docs#show'

  match '/discardfl', :to => "request#discardfl"
  match '/discardflform/:id', :to => "request#discardflform"

  match '/mon(/:id)', :to => 'monitoring#mon'
  match '/monnodes', :to => 'monitoring#index'
  match '/graph/:id(/:hour)', :to => 'monitoring#show'
  match '/tp/:id', :to => 'monitoring#tariffs'
  match '/errorlist/:id', :to => 'monitoring#errorlist'
  match '/payments/:id', :to => 'monitoring#payments'

  match '/login', :to => 'sessions#new'
  match '/logout', :to =>  'sessions#destroy'

  match '/statistic', :to => 'statistic#index'
  match '/nodestatistic(/:id)', :to => 'statistic#show'

  match "/request", :to => "request#index"
  match "/newfl", :to => "request#newfl"
  match "/createfl", :to => "request#createfl"
  match "/requestfl/:id", :to => "request#requestfl"
  match "/readystatusfl/:id", :to => "request#readystatusfl"
  match "/connectedstatusfl/:id", :to => "request#connectedstatusfl"
  match "/finishstatusfl/:id", :to => "request#finishstatusfl"

  match "/getsumms", :to => 'balances#getsumms'
  match "/balances", :to => "balances#index"

end
