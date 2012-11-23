BrowSql::Engine.routes.draw do
  root :to => 'tables#index'
  
  resources :tables do
    resources :records
  end
  
end
