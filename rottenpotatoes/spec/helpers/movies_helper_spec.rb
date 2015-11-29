require 'spec_helper'
require 'rails_helper'

describe MoviesHelper do
  describe 'oddness' do

    it 'should return "odd" for odd numbers' do
      expect(oddness(1)).to eq('odd')
      expect(oddness(3)).to eq('odd')
      expect(oddness(99)).to eq('odd')
    end

    it 'should return "even" for even numbers' do
      expect(oddness(2)).to eq('even')
      expect(oddness(4)).to eq('even')
      expect(oddness(100)).to eq('even')
    end

  end
end
