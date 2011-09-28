Contests::Application.routes.draw do
  resources :problems
  resources :teams
  
  resources :contests do
      resources :submissions, :only => :index
  end
  
  resource :session
  root :to => "contests#index"
end
