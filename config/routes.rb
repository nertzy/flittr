Flittr::Application.routes.draw do
  resources :users
  resources :statuses
  post "search", :to => "search#index"
  root :to => "welcome#index"
end
