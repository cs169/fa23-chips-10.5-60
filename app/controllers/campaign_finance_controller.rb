# frozen_string_literal: true

require 'net/http'

class CampaignFinanceController < ApplicationController
  before_action :validate_params, only: [:search]

  def get_api_response(cycle, category)
    uri = URI("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    request = Net::HTTP::Get.new(uri)
    request['X-API-Key'] = Rails.application.credentials[:PROPUBLICA_API_KEY]
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON.parse(response.body)
  end

  def search
    cycle = params[:cycle]
    category = params[:category]
    json = get_api_response(cycle, category)
    @campaign_finances = CampaignFinance.from_api(json)

    render 'campaign_finance/search'
  end

  VALID_CATEGORIES = %w[
    candidate-loan
    contribution-total
    debts-owed
    disbursements-total
    end-cash
    individual-total
    pac-total
    receipts-total
    refund-total
  ].freeze

  def validate_params
    unless VALID_CATEGORIES.include?(params[:category])
      redirect_to root_path, alert: "Invalid category: '#{params[:category]}'"
    end
    num = params[:cycle].to_i
    return if num.between?(2010, 2020) && num.even?

    redirect_to root_path, alert: "Invalid cycle year: '#{params[:cycle]}'"
  end

end
