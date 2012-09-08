Bgwebmon::Application.routes.draw do

  resources :sessions do
    collection do 
      get :new
      post :create
      delete :destroy
    end
  end

  root :to => "monitoring#index"

  match '/mon', :to => 'monitoring#index'
  match '/graph/:id(/:hour)', :to => 'monitoring#show'
  match '/dpupd', :to => 'monitoring#dpupdate'
  match '/errorlist/:id', :to => 'monitoring#errorlist'
  match '/payments/:id', :to => 'monitoring#payments'
  match '/login', :to => 'sessions#new'
  match '/logout', :to =>  'sessions#destroy'
end
