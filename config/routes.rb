Contests::Application.routes.draw do
  resources :contests do
      resources :submissions, :only => :index
      resources :teams
  end

  resource :session
  root :to => "contests#index"
end
