# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

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

      if Representative.find_by(name: official.name).nil?
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
            title: title_temp })
      else
        rep = Representative.find_or_initialize_by(name: official.name)
        rep.update(ocdid: ocdid_temp, title: title_temp)
      end

      rep.update!(
        address: official.address,

        # other rep info
        political_party: official.party,
        photo_url: official.photo_url,
        ocdid: ocdid_temp,
        title: title_temp
        # name:            official.name,
        # title:           title_temp,
        # address:         official.address,
        # address_street:  official.address[0].street,
        # city:            address[:city],
        # state:           address[:state],
        # zip:             address[:zip],
        # political_party: official.party,
        # photo_url:       official.photo_url

      )
      

    #   rep.update!(

    #   #address info:
    #   address: "#{official.address&.line1} #{official.address&.city} #{official.address&.state} #{official.address&.zip}",

    #   address_street: official.address&.line1,
    #   address_city: official.address&.city,
    #   address_state: official.address&.state,
    #   address_zip: official.address&.zip,

    #   # other rep info
    #   political_party: official.political_party,
    #   photo_url: official.photo_url,
    #   ocdid: ocdid_temp,
    #   title: title_temp

    # )
      reps.push(rep)
    end
    reps
  end
end
