require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching by similar director' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it 'should call the model method that performs search by same director' do
      expect(Movie).to receive(:search_directors).with(99).
        and_return(@fake_results)
      get :search_directors, {id: 99}
    end
    
    it 'should select the Search Directors template for rendering' do
      # Movie.stub(:search_directors).and_return(@fake_results)
      allow(Movie).to receive(:search_directors).and_return(@fake_results)
      get :search_directors, {id: 99}
      expect(response).to render_template('search_directors')
    end

    it 'should make the search director search results available to that template' do
      allow(Movie).to receive(:search_directors).and_return(@fake_results)
      get :search_directors, {id: 99}
      # assigns(:movies).should == @fake_results
      expect(assigns(:movies)).to be == @fake_results
    end

  end
end