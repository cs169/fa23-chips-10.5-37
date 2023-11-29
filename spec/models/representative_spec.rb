# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  it 'creates a valid representative' do
    rep = described_class.new(name: 'First Last', ocdid: 'ocd-division/country:us', title: 'Judge')
    expect(rep).to be_valid
  end
end
# it 'does not create duplicate' do
#   expect(rep).not_to receive(:create!)
# end
