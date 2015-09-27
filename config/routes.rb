Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root :to => 'application#home'
  match ':controller(/:action(/:id))', :via => [:get, :post]
end
