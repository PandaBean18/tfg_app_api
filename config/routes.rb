Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    # user routes
    get('/user', to: 'users#show')
    post('/user', to: 'users#create')
    patch('/user', to: 'users#update')
    delete('/user', to: 'user#destroy')
    patch('/update_password', to: 'users#update_password')

    # authentication routes
    post('/auth/login', to: 'authentication#login')
    post('/logout', to: 'authentication#logout')

    # posts routes 
    post('/post', to: 'posts#create')
end
