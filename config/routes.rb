Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get('/user', to: 'users#show')
    post('/user', to: 'users#create')
    patch('/user', to: 'users#update')
    delete('/user', to: 'user#destroy')
    patch('/update_password', to: 'users#update_password')
    post('/auth/login', to: 'authentication#login')
    post('/logout', to: 'authentication#logout')
end
