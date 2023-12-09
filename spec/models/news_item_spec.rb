# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# param order --> :news, :title, :description, :link, :representative_id
RSpec.describe NewsItem, type: :model do
  describe 'tesing the .find_for methods' do
    context 'when a news item is found' do
      let(:representative) { Representative.create(name: 'Silly Sally') }
      let!(:news_item) { described_class.create(title: 'Goods News', link: 'cnn.com', representative: representative) }

      it 'returns a news item for a given representative_id' do
        found_news_item = described_class.find_for(representative.id)
        expect(found_news_item).to eq(news_item)
      end
    end

    context 'when no news is found' do
      it 'returns nil' do
        found_news_item = described_class.find_for(422)
        expect(found_news_item).to be_nil
      end
    end

    # test for to find news for a rep not in system?
  end
end
