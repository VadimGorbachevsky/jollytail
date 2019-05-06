Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations"}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'startpage/index'
  root 'startpage#index'

  get 'politic', to: 'politic#index.html', as: :politic
  get 'delivery', to: 'politic#delivery.html', as: :delivery
  get 'credits', to: 'politic#credits.html.erb', as: :credits

  resources :products
  resources :users
  resources :categories
  resources :carts
  resources :orders
  resources :accias
  resources :positions
  resources :reviews

  get 'update_all', to: 'products#update_all', as: :products_update_all
  get '403', to: 'errors#403.html', as: :_403

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
