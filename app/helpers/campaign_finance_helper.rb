# frozen_string_literal: true

module CampaignFinanceHelper
  def campaign_finance_categories
    %w[candidate-loan contribution-total debts-owed
       disbursements-total end-cash individual-total
       pac-total receipts-total refund-total]
  end
end
