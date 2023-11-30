# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show_by_county
    @county = params[:std_fips_code]
    @representatives = Representative.where(county: @county)
    # Add any additional logic you need for displaying representatives in this county
  end
end
