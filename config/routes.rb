Bgwebmon::Application.routes.draw do
  resources :sessions do
    collection do 
      get :new
      post :create
      delete :destroy
    end
  end

  root :to => "menu#index"

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
end
