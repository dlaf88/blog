Rails.application.routes.draw do
  resources :orders
  root 'welcome#index'
end
