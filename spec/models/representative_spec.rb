require 'rails_helper'
require 'spec_helper'

describe Representative do
  before :each do
    rep = Representative.create!(name: 'First Last', ocdid: 'ocd-division/country:us', title: 'Judge')
  end

  describe 'valid representative with assigned attributes'
    it 'creates a valid representative' do
      expect(rep).to be_valid
    end
    # it 'does not create duplicate' do
    #   expect(rep).not_to receive(:create)
    # end
  end

  
    

end