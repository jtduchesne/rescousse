class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places, id: :uuid do |t|
      t.timestamps
      t.string :name
      
      t.string :address
      t.string :hood
      t.string :city
      t.string :province
      t.string :postcode
      
      t.float  :latitude
      t.float  :longitude
      
      t.string :phone
      t.string :email
      t.string :website
    end
  end
end
