require 'spec_helper'
 
describe Movie do
  describe 'searching by director' do
    before :each do
      @movieA1 = Movie.create(title: 'One', director: 'Director A')
      @movieA2 = Movie.create(title: 'Two', director: 'Director A')
      @movieA3 = Movie.create(title: 'Three', director: 'Director A')
      @movieB1 = Movie.create(title: 'Three', director: 'Director B')
      @results_by_A = [@movieA1, @movieA2, @movieA3]
    end

    it 'should find movies by the same director' do
      expect(@movieA1.search_by_director).to include(@movieA1)
      expect(@movieA1.search_by_director).to include(@movieA2)
      expect(@movieA1.search_by_director).to include(@movieA3)
    end
    
    it 'should not find movies by a different director' do
      expect(@movieA1.search_by_director).not_to include(@movieB1)
    end

  end
end
