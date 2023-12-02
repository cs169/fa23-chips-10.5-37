# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'user init method tests' do
    let(:user1) { described_class.new(first_name: 'Jim', last_name: 'Carrey', 
    provider: 'google_oauth2', uid: '889') }
    let(:user2) { described_class.new(first_name: 'Carrey', last_name: 'Jim', 
    provider: 'github', uid: '889') }

    it 'returns the full name' do
      expect(user1.name).to eq('Jim Carrey')
      expect(user2.name).to eq('Carrey Jim')
    end

    it 'returns the autho provider' do
      expect(user1.auth_provider).to eq('Google')
      expect(user2.auth_provider).to eq('Github')
    end
  end
end
# describe 'find user method tests' do
    # let(:github_user) { described_class.create(first_name: 'git', last_name: 'hub', provider: 'github', uid: '420') }
    # let(:google_user) { described_class.create(first_name: 'google', last_name: 'auth', provider: 'google_oauth2', uid: '069') }

    # it 'finds github with UID' do
      # found = described_class.find_github_user('420')
      # expect(found).to eq(github_user)
    # end

    # it 'finds google with UID' do
      # found = described_class.find_google_user('069')
      # expect(found).to eq(google_user)
    # end
  # end
