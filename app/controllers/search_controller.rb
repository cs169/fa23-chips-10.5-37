# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]

    begin
      result = service.representative_info_by_address(address: address)
      @representatives = Representative.civic_api_to_representative_params(result)

      render 'representatives/search'
    rescue Google::Apis::Error => e
      invalid_address(e)
    end
  end

  def invalid_address(_err)
    flash[:alert] = 'Invalid address'
    render 'representatives/index'
  end
end
