Rails.application.routes.draw do
# admin側のルーティング
devise_for :admins, controllers: {
	sessions:      'admins/sessions',
	passwords:     'admins/passwords',
	registrations: 'admins/registrations'
}

namespace :admin do
	root 'home#top'
	resources :members, only: [:index,:show,:edit,:update]
	resources :products, only: [:index,:new,:create,:show,:edit,:update,:destroy]
	resources :genres, only: [:index,:create,:edit,:update,:destroy]
	resources :orders, only: [:index,:show,:update]
	resources :member_searches, only: [:index]
	patch 'order_items/:id' => 'orders#item_update'
	put 'order_items/:id' => 'orders#item_update'
end

# member側のルーティング
root 'home#top'
get 'home/about' => "home#about"
get 'searches' => 'searches#index', as: 'searches'
devise_for :members, controllers: {
	sessions:      'members/sessions',
	passwords:     'members/passwords',
	registrations: 'members/registrations'
}


resource :member, only: [:edit,:show,:update] do
	get 'cancel' => 'members#cancel'
	patch 'withdraw' => 'members#withdraw'
	put 'withdraw' => 'members#withdraw'

	resources :products, only: [:index,:show]

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
	resources :cart_items, only: [:index,:create,:update,:destroy]

    post 'orders/confirm',to: 'orders#confirm',as: 'orders_confirm'
	resources :orders, only: [:new,:create,:index,:show]


	resources :shipping_addresses, only: [:index,:edit,:create,:update,:destroy]



end





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
