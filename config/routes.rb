Rails.application.routes.draw do
  root 'home#index'      #home-controller,index-action    
# get '/home' => 'home#index'
  get 'about', to: 'page#about'
end
