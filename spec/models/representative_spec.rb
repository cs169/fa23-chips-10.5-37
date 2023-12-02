# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  it 'creates a valid representative' do
    rep = described_class.new(name: 'First Last', ocdid: 'ocd-division/country:us', title: 'Judge')
    expect(rep).to be_valid
  end

  before do
    @rep_info = OpenStruct.new(
        officials: [
          OpenStruct.new(
          name: 'Mary Jane',
          title: 'Mayor',
          address: '808 Roll St',
          ocdid: 'ocd-division/country:us',
          party: 'Dependent',
          photo_url: 'https://i.pinimg.com/736x/71/fe/83/71fe83b3f2423bb24a925ff72565fd0e.jpg'),
          OpenStruct.new(name: 'Snoop Dog',
          title: 'Governor',
          address: '212 Hollywood Ave',
          ocdid: 'ocd-division/country:ny',
          party: 'Independent',
          photo_url: 'https://mlgstuff.weebly.com/uploads/5/2/1/9/52194987/5683457.jpg?326')
        ],
        offices: [
          OpenStruct.new(
          name: 'Town Hall',
          official_indices: [0]),
          OpenStruct.new(
          name: 'Governor Hall',
          official_indices: [1])
        ]
      )
  end
end
# it 'does not create duplicate' do
#   expect(rep).not_to receive(:create!)
# end
