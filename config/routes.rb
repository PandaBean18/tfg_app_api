Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    # user routes
    get('/users/:id', to: 'users#show')
    post('/user', to: 'users#create')
    patch('/user', to: 'users#update')
    delete('/user', to: 'user#destroy')
    patch('/update_password', to: 'users#update_password')
    get('/user/avatar', to: 'users#avatar')

    # authentication routes
    post('/auth/login', to: 'authentication#login')
    post('/logout', to: 'authentication#logout')

    # posts routes 
    post('/rr', to: 'rescue_requests#create')
    get('/rr/all', to: 'rescue_requests#index')
    get('/rr/:id', to: 'rescue_requests#show')
    patch('/rr/:id', to: 'rescue_requests#update')
    patch('/rr/:id/close', to: 'rescue_requests#close')
    delete('/rr/:id', to: 'rescue_requests#destroy')

end
