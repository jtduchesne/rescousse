class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions, id: :uuid do |t|
      t.timestamps
      t.inet    :ip_address
      
      t.string  :city
      t.string  :province
      t.string  :country
      
      t.float   :latitude
      t.float   :longitude
      
      t.integer :count
    end
  end
end
