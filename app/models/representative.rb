# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  validates_presence_of :name, :ocdid, :title, :address_street, :address_city, :address_state, :address_zip, :political_party, :photo_url

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    # loop for each rep 
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      # parse OCD ID (divsion id) and Title (office name)
      rep_info.offices.each do |office|
        # chk to make sure index val is present in office if so... execute
        if office.official_indices.include? index
          ocdid_temp = office.division_id
          title_temp = office.name
          
        end
      end

      # find rep then either update it or create it
      # find or create vs find or init... init calls new --> make a *new* rep obj 
      # e.i. both create and update
      rep = Representative.find_or_initialize_by(name: official.name)

      # once rep eobj exists, update it to contain parsed info
      rep.update!(

        #address info:
        address: "#{official.address&.line1} #{official.address&.city} #{official.address&.state} #{official.address&.zip}",

        address_street: official.address&.line1,
        address_city: official.address&.city,
        address_state: official.address&.state,
        address_zip: official.address&.zip,

        # other rep info
        political_party: official.political_party,
        photo_url: official.photo_url,
        ocdid: ocdid_temp,
        title: title_temp

      )

      reps.push(rep)
    end

    reps
  end
end
