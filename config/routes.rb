Contests::Application.routes.draw do
  resources :submissions

  resources :problems

  resources :teams

  resources :contests
  root :to => "contests#index"
end
