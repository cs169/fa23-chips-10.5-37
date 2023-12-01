# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    # @county = params[:std_fips_code]
    @representative = Representative.find_by(id: params[:id])
    # Add any additional logic you need for displaying representatives in this county
  end
end
