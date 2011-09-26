Contests::Application.routes.draw do
  resources :problems

  resources :teams

  resources :contests
  root :to => "contests#index"
end
