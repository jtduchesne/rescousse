class RenameGoogleMapsIdToUidInPlaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :places, :google_maps_id, :uid
  end
end
