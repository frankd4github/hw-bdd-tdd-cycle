require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching by similar director' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it 'should call the model method that performs search by same director when director for movie is set' do
      movie99 = instance_double("Movie", id: 99, director: 'Non nil')
      allow(Movie).to receive(:find).and_return(movie99)
      expect(movie99).to receive(:search_directors).and_return(@fake_results)
      get :search_directors, {id: 99}
    end
    
    it 'should set the flash when director for movie is not set' do
      movie99 = instance_double("Movie", id: 99, title: 'The 99', director: nil)
      allow(Movie).to receive(:find).and_return(movie99)
      expect(flash).to receive(:alert=).with(/director/)
      #expect(sessionflash[:alert]).to match /no director/
      #flash[:alert].should =~ /no director/i
      get :search_directors, {id: 99}
    end

    it 'should select the Search Directors template for rendering' do
      # Movie.stub(:search_directors).and_return(@fake_results)
      movie99 = instance_double("Movie", id: 99, title: 'The 99', director: 'director99')
      allow(Movie).to receive(:find).and_return(movie99)
      allow(movie99).to receive(:search_directors).and_return(@fake_results)
      expect(response).to render_template('search_directors')
      get :search_directors, {id: 99}
    end

    it 'should make the search director search results available to the template' do
      movie99 = instance_double("Movie", id: 99, title: 'The 99', director: 'director99')
      allow(Movie).to receive(:find).and_return(movie99)
      allow(movie99).to receive(:search_directors).and_return(@fake_results)
      expect(assigns(:movies)).to be == @fake_results
      get :search_directors, {id: 99}
      # assigns(:movies).should == @fake_results
    end

    it 'should make the search director search results available to that template' do
    end
  end
end