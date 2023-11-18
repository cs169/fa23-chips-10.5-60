class AddDetailedInformationToRepresentatives < ActiveRecord::Migration[5.2]
  def change
      add_column :street, :city, :state, :zip, :political_party, :photo_url, :string
  end
end
