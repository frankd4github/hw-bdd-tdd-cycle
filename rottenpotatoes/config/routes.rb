Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

  # map /movie/search_director/:id to 
  get '/movies/:id/same_director', to: 'movies#search_by_director' #, as: :search_by_director
end
