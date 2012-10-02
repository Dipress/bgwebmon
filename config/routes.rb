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
  match '/monbs', :to => 'monitoring#index'
  match '/graph/:id(/:hour)', :to => 'monitoring#show'
  match '/tp/:id', :to => 'monitoring#tariffs'
#  match '/dpupd', :to => 'monitoring#dpupdate'
  match '/errorlist/:id', :to => 'monitoring#errorlist'
  match '/payments/:id', :to => 'monitoring#payments'
  match '/login', :to => 'sessions#new'
  match '/logout', :to =>  'sessions#destroy'
end
