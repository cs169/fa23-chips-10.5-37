# frozen_string_literal: true

class RepresentativesController < ApplicationController
  # show all reps
  def index
    @representatives = Representative.all

  end

  # show reps in 'representative/search'
  def show
    @representative = Representative.find_by(id: params[:id])

  end

  # show reps by county, define county to find reps
  def show_by_county
    @county = params[:std_fips_code]
    @representatives = Representative.where(county: @county)
    # Add any additional logic you need for displaying representatives in this county

  end
  
  def show
    # @county = params[:std_fips_code]
    @representative = Representative.find_by(id: params[:id])
    # Add any additional logic you need for displaying representatives in this county
  end
end
