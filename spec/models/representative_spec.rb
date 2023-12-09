# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  let(:rep_info) do
    OpenStruct.new(
      officials: [
        OpenStruct.new(
          name:      'Mary Jane',
          title:     'Mayor',
          address:   [
            OpenStruct.new(
              line1: '808 Roll St',
              line2: 'Apt 5',
              city:  'Some City',
              state: 'CA',
              zip:   '12345'
            )
          ],
          party:     'Dependent',
          photo_url: 'https://i.pinimg.com/736x/71/fe/83/71fe83b3f2423bb24a925ff72565fd0e.jpg'
        ),
        OpenStruct.new(
          name:      'Snoop Doggy',
          title:     'Governor',
          address:   [
            OpenStruct.new(
              line1: '212 Hollywood Ave',
              city:  'Another City',
              state: 'NY',
              zip:   '67890'
            )
          ],
          party:     'Independent',
          photo_url: 'https://mlgstuff.weebly.com/uploads/5/2/1/9/52194987/5683457.jpg?326'
        )
      ],
      offices:   [
        OpenStruct.new(
          name:             'Town Office',
          division_id:      'ocdid0',
          official_indices: [0]
        ),
        OpenStruct.new(
          name:             'Governor Office',
          division_id:      '',
          official_indices: [1]
        )
      ]
    )
  end

  context 'validation' do
    it 'creates a valid representative' do
      rep = described_class.new(name: 'First Last', ocdid: 'ocdid2', title: 'Judge')
      expect(rep).to be_valid
    end
  end

  # it 'updates an existing representative' do

  # end

  it 'does not create duplicate representatives' do
    # no reps exist first
    expect(described_class.count).to eq(0)
    described_class.civic_api_to_representative_params(rep_info)
    rep_double_chk = described_class.civic_api_to_representative_params(rep_info)
    # no doubles
    expect(described_class.count).to eq(rep_double_chk.count)
  end

  describe 'checking address stuff' do
    it 'parses an address correctly' do
      address = [OpenStruct.new(line1: '123 Your Mom', line2: 'Apt 4', city: 'City', state: 'TX', zip: '12345')]
      formatted = described_class.parse_address(address)
      expect(formatted).to eq('123 Your Mom, Apt 4  City, TX 12345')
    end

    it 'handles an empty line2' do
      address = [OpenStruct.new(line1: '456 Your Dad', city: 'Not a City', state: 'Canada', zip: '54321')]
      formatted = described_class.parse_address(address)
      expect(formatted).to eq('456 Your Dad, Not a City, Canada 54321')
    end
  end

  describe 'ocdid checking' do
    it 'returns proper ocdid' do
      ocdid, title = described_class.ocdid_title(rep_info, 0)
      expect(ocdid).to eq('ocdid0')
      expect(title).to eq('Town Office')
    end

    it 'returns empty if info not provided' do
      ocdid, title = described_class.ocdid_title(rep_info, 1)
      expect(ocdid).to eq('')
      expect(title).to eq('Governor Office')
    end
  end
end
