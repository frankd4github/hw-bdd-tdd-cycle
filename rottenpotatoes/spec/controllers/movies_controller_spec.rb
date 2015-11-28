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

    it 'should make the search director search results available to that template' do
      movie99 = instance_double('Movie', id: 99, title: 'The 99', director: 'Director 99')
      expect(Movie).to receive(:find).and_return(movie99)
      expect(movie99).to receive(:search_by_director).and_return(@fake_results)
      get :search_by_director, {id: 99}
      expect(assigns(:movies)).to be == @fake_results
    end

  end
end