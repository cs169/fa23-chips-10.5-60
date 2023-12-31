# frozen_string_literal: true

class AddIssueToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :issue, :string, default: 'default', null: false unless column_exists? :news_items, :issue
  end
end
