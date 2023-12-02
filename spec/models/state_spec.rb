# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe State, type: :model do
  describe 'testing std_fips_code method in state' do
    context 'when the given code is above range' do
      let(:county) { described_class.create(fips_code: 51) }

      it 'returns the standardized FIPS code' do
        expect { county.std_fips_code }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
