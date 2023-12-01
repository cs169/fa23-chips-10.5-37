# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Layout/LineLength

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

      parsedaddress = official.address ? parse_address(official.address) : ''

      rep.update!(
        address:         parsedaddress,
        political_party: official.party,
        photo_url:       official.photo_url || "No Photo",
        ocdid:           ocdid_temp,
        title:           title_temp

      )

      reps.push(rep)
    end
    reps
  end

  def self.parse_address(addr)
    fulladdress = "#{addr[0].line1}, "
    if addr[0].line2 != nil
      fulladdress += "#{addr[0].line2} "
    end
    if addr[0].line3
      fulladdress += "#{addr[0].line3} "
    end
    fulladdress += "#{addr[0].city}, "
    fulladdress += "#{addr[0].state} #{addr[0].zip}"
    fulladdress
  end
end
