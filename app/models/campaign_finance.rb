# frozen_string_literal: true

class CampaignFinance < ApplicationRecord
  def self.from_api(finance_info)
    finances = []
    finance_info['results'].each do |candidate_data|
      candidate = from_data(candidate_data, finance_info['category'], finance_info['cycle'])
      finances.push(candidate)
    end
    finances
  end

  # This will create duplicates if the reps info changes
  # At a later date this could be modified to update information
  # if necessary.
  def self.from_data(candidate_data, category, cycle)
    finance_attrs = build_finance_attributes(candidate_data, category, cycle)
    CampaignFinance.find_or_create_by(finance_attrs)
  end

  def self.build_finance_attributes(candidate_data, category, cycle)
    { category:               category,
      cycle:                  cycle,
      relative_uri:           safe_string_access(candidate_data, :relative_uri),
      name:                   safe_string_access(candidate_data, :name),
      party:                  safe_string_access(candidate_data, :party),
      state:                  safe_string_access(candidate_data, :state),
      district:               safe_string_access(candidate_data, :district),
      comittee:               safe_string_access(candidate_data, :comittee),
      status:                 safe_string_access(candidate_data, :status),
      total_from_individuals: safe_decimal_access(candidate_data, :total_from_individuals),
      total_contributions:    safe_decimal_access(candidate_data, :total_from_contributions),
      candidate_loans:        safe_decimal_access(candidate_data, :candidate_loans),
      total_disbursements:    safe_decimal_access(candidate_data, :total_disbursements),
      begin_cash:             safe_decimal_access(candidate_data, :begin_cash),
      end_cash:               safe_decimal_access(candidate_data, :end_cash),
      total_refunds:          safe_decimal_access(candidate_data, :total_refunds),
      debts_owed:             safe_decimal_access(candidate_data, :debts_owed),
      date_coverage_from:     safe_date_access(candidate_data, :date_coverage_from),
      date_coverage_to:       safe_date_access(candidate_data, :date_coverage_to) }
  end

  def self.safe_string_access(object, attr)
    object[attr] || ''
  end

  def self.safe_decimal_access(object, attr)
    object[attr] || 0
  end

  def self.safe_date_access(object, attr)
    object[attr] || Time.zone.today
  end
end
