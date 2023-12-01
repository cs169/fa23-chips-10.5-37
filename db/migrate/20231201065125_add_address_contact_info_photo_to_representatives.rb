class AddAddressContactInfoPhotoToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :political_party, :string
    add_column :representatives, :address, :string
    add_column :representatives, :photo_url, :string
  end
end
