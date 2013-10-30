Bgwebmon::Application.routes.draw do

  get "api/monitoring"

  resources :agent_payments, only: [:new, :create, :update, :edit, :show, :processing, :index] do
    put :confirmation, on: :member
    put :processing, on: :member
  end


  resources :sessions do
    collection do 
      get :new
      post :create
      delete :destroy
    end
  end

  resources :tasks

  root :to => "menu#index"

  scope 'api' do
    match '/get_contracts', to: 'ajax#get_contracts'
    match '/asterisk', to: 'api#asterisk'
  end

  match '/members', to: 'api#monitoring'

  match '/taskcommentnew', :to => 'tasks#commentcreate'
  match '/taketask/:id', :to => 'tasks#take'
  match '/deletetcomment/:id', :to => "tasks#deletetcomment"
  match '/tstatuschange/:id', :to => "tasks#tstatuschange"
  match '/tstatuschangeopen/:id', :to => "tasks#tstatuschangeopen"
  match '/deletetask/:id', :to => "tasks#destroy"
  match '/addfile/:id', :to => 'tasks#addfile', :via => :post

  match '/docs', :to => 'docs#index'
  match '/doc/:title(/:query)', :to => 'docs#show'

  match '/discardfl', :to => "request#discardfl"
  match '/discardflform/:id', :to => "request#discardflform"

  match '/mon(/:id)', :to => 'monitoring#mon'
  match '/new_mon', :to => 'monitoring#new_mon'
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
  match "/editfl/:id", :to => "request#editfl"
  match "/updatefl/:id", :to => "request#updatefl"
  match "/requestfl/:id", :to => "request#requestfl"
  match "/readystatusfl/:id", :to => "request#readystatusfl"
  match "/connectedstatusfl/:id", :to => "request#connectedstatusfl"
  match "/finishstatusfl/:id", :to => "request#finishstatusfl"

  match "/getsumms", :to => 'balances#getsumms'
  match "/balances", :to => "balances#index"

end
