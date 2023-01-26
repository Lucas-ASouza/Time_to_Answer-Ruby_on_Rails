Rails.application.routes.draw do

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject' 
    #as to manually set the route path
    
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins #Adminstrator's Pages
    resources :subjects #Subject's Pages
    resources :questions #Question's Pages
  end

  devise_for :admins
  devise_for :users


  get 'home', to: 'site/welcome#index'
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
