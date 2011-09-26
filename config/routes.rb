Contests::Application.routes.draw do
  resources :teams

  resources :contests
  root :to => "contests#index"
end
