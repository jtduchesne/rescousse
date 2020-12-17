class AddGoogleMapsIdToPlace < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :website, :string
    remove_column :places, :email,   :string
    remove_column :places, :phone,   :string
    
    add_column :places, :google_maps_id, :string
    
    add_column :places, :phone,   :string
    add_column :places, :website, :string
  end
end
