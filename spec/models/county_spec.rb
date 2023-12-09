# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe County, type: :model do
  describe 'testing std_fips_code method in county' do
    context 'when the given code is within range' do
      let(:county) { described_class.create(fips_code: 777) }

      it 'returns the standardized FIPS code' do
        expect(county.std_fips_code).to eq('777')
      end
    end
  end
end
