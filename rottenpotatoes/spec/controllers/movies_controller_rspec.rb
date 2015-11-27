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
      #Movie.should_receive(:search_directors).with('99').
      #  and_return(@fake_results)
      post :search_directors, {id: 99}
    end
  end
end