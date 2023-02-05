Rails.application.routes.draw do
  root 'pages#home'      #pages-controller,home-action    
# get '/pages' => 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'students#new'
  resources :students, except: [:new]
end
