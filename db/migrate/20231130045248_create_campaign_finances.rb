class CreateCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_finances do |t|
      t.string :relative_uri
      t.string :name
      t.string :party
      t.string :state
      t.string :district
      t.string :comittee
      t.string :status
      t.decimal :total_from_individuals
      t.decimal :total_from_pacs
      t.decimal :total_contributions
      t.decimal :candidate_loans
      t.decimal :total_disbursements
      t.decimal :begin_cash
      t.decimal :end_cash
      t.decimal :total_refunds
      t.decimal :debts_owed
      t.date :date_coverage_from
      t.date :date_coverage_to

      t.timestamps
    end
  end
end
