Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

  # map /movie/search_director/:id to 
  get '/movies/:id/search_directors', to: 'movies#search_directors', as: :search_directors
end
