# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  validates_presence_of :name, :ocdid, :title, :address_street, :address_city, :address_state, :address_zip, :party, :photo

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!(
        name: official.name,
        ocdid: ocdid_temp,
        title: title_temp,
        address_street: official.address&.line1,
        address_city: official.address&.city,
        address_state: official.address&.state,
        address_zip: official.address&.zip,
        party: official.party,
        photo: official.photoUrl
      )
      reps.push(rep)
    end

    reps
  end
end
