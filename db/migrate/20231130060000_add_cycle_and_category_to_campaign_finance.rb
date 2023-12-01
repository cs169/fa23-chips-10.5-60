# frozen_string_literal: true

class AddCycleAndCategoryToCampaignFinance < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_finances, :category, :string
    add_column :campaign_finances, :cycle, :integer
  end
end
