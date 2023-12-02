# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'user init method tests' do
    let(:user1) { described_class.create(first_name: 'Jim', last_name: 'Carrey', provider: 'google_oauth2', uid: '420') }
    let(:user2) { described_class.create(first_name: 'Carrey', last_name: 'Jim', provider: 'github', uid: '069') }

    it 'returns the full name' do
      expect(user1.name).to eq('Jim Carrey')
      expect(user2.name).to eq('Carrey Jim')
    end

    it 'returns the autho provider' do
      expect(user1.auth_provider).to eq('Google')
      expect(user2.auth_provider).to eq('Github')
    end
  end

  describe 'find the user with the uid' do
    it 'finds github with UID' do
      git_user = described_class.create(provider: 'github', uid: '123')
      found = described_class.find_github_user('123')
      expect(found).to eq(git_user)
    end

    it 'finds google with UID' do
      goo_user = described_class.create(provider: 'google_oauth2', uid: '456')
      found = described_class.find_google_user('456')
      expect(found).to eq(goo_user)
    end
  end
end
