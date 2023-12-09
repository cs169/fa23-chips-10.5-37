# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe NewsItem, type: :model do
  describe 'rep related news item interactions' do
    let(:rep) do
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
          )
        ],
        offices:   [
          OpenStruct.new(
            name:             'Town Office',
            division_id:      'ocdid0',
            official_indices: [0]
          )
        ]
      )

      context 'validation' do
        it 'creates a valid news item' do
          news = described_class.new(title: 'Babies', link: 'working-babies.com',
                                     description: 'how to legally hire a baby as an employee!',
                                     issue: 'Unemployment', representative: rep)
          expect(news).to be_valid
        end
      end
    end

    context 'finds the news using a valid rep id' do
      let(:representative) { instance_double(Representative, id: 1) }
      let(:news) { instance_double(described_class) }

      #   let(:news) do
      #     described_class.create(
      #       representative_id: representative,
      #       title: 'Babies',
      #       link: 'working-babies.com',
      #       description: 'how to legally hire a baby as an employee!',
      #       issue: 'Unemployment'
      #     )
      #   end
      before do
        allow(described_class).to receive(:find_for)
      end

      it 'finds the good news!' do
        described_class.find_for(representative.id)
        expect(described_class).to have_received(:find_for).with(representative.id)
      end
    end

    context 'rets nil news when using an invalid rep id' do
      it 'returns nil' do
        found = described_class.find_for(8)
        expect(found).to be_nil
      end
    end
  end

  describe 'testing other NewsItem method and functionality' do
    context 'checking the issues_list method' do
      it 'returns the correct list of issues' do
        issues = described_class.issues_list
        expected_issues = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
                           'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
                           'Climate Change', 'Homelessness', 'Racism', 'Tax Reform',
                           'Net Neutrality', 'Religious Freedom', 'Border Security',
                           'Minimum Wage', 'Equal Pay']
        expect(issues).to eq(expected_issues)
      end
    end
  end
end
