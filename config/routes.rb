Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, only: [:create, :show, :update, :destroy]
    patch('/users/:id/update_password', to: 'users#update_password')
end
