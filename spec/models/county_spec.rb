<<<<<<< HEAD
require 'rails_helper'

RSpec.describe County, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
=======
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
    # can county be out of range?
  end
>>>>>>> a8edf3850690bb7fc9c93b6a8d809b3882ec27d6
end
