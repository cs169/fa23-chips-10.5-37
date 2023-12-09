# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find_by(id: params[:id])

    redirect_to representatives_path, alert: 'Sorry, Representative Not Found!' if @representative.nil?
  end
end
