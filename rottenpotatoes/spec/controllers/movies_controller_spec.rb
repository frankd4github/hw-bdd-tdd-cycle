require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching by similar director' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it 'should call the model method that performs search by same director' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99', director: 'Director 99')
      expect(Movie).to receive(:find).and_return(movie99)
      expect(movie99).to receive(:search_by_director).and_return(@fake_results)
      get :search_by_director, {id: 99}
    end
    
    it 'should select the Search Directors template for rendering' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99', director: 'Director 99')
      expect(Movie).to receive(:find).and_return(movie99)
      expect(movie99).to receive(:search_by_director).and_return(@fake_results)
      get :search_by_director, {id: 99}
      expect(response).to render_template('search_by_director')
    end

    it 'should make the search director search results available to the template' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99', director: 'Director 99')
      expect(Movie).to receive(:find).and_return(movie99)
      expect(movie99).to receive(:search_by_director).and_return(@fake_results)
      get :search_by_director, {id: 99}
      expect(assigns(:movies)).to be == @fake_results
    end

    it 'should set the flash when director is not set' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99', director: nil)
      expect(Movie).to receive(:find).and_return(movie99)
      get :search_by_director, {id: 99}
      expect(flash[:warning]).not_to be_nil
    end
  end

  describe 'view movie' do
    it 'should call the Model find method with id parameter passed' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99')
      expect(Movie).to receive(:find).and_return(movie99)
      get :show, {id: 99}
    end
    it 'should set instance variable for the view to use and render show template' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99')
      expect(Movie).to receive(:find).and_return(movie99)
      expect(assigns(@movie))
      get :show, {id: 99}
      expect(response).to render_template(:show)
    end

    it 'should show error for non-existing movie' do
    end
  end

  describe 'create movie' do
    it 'should call the Model create! method with parameters passed, redirect to index and set flash' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99')
      expect(Movie).to receive(:create!).and_return movie99 #.with_parameters(title: 'New movie', rating: 'R', description: 'New movie', release_date: '2015-01-01')
      post :create, {'movie' => {'title' => 'The 99', 'rating' => 'R', 'description' => 'The 99', 'release_date' => '2015-01-01'}}
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to match(/was successfully created/)
    end
  end

  describe 'destroy movie' do
    it 'should call the Model find and destroy methods with parameter id passed, redirect to index and set flash' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99')
      expect(Movie).to receive(:find).with('99').and_return(movie99)
      expect(movie99).to receive(:destroy)
      post :destroy, {id: 99}
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to match(/Movie '[^']+' deleted/)
    end
  end

  describe 'update movie' do
    it 'should call the Model find and update methods with parameters passed, redirect to index and set flash' do
      movie99 = Movie.new id: 99, title: 'The 99'
      expect(Movie).to receive(:find).with('99').and_return(movie99)
      expect(movie99).to receive(:update_attributes!)
      post :update, {'id' => 99, 'movie' => {'title' => 'The new 99', 'rating' => 'R', 'description' => 'The 99'}}
      expect(response).to redirect_to(movie_path(movie99))
      expect(flash[:notice]).to match(/was successfully updated/)
    end
  end

end