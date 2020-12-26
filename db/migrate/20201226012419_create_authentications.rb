class CreateAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :authentications, id: :uuid do |t|
      t.timestamps
      t.belongs_to :user, null: false, type: :uuid, foreign_key: true
      t.string :provider, null: false
      t.string :uid,      null: false
    end
    
    add_index :authentications, [:provider, :uid], unique: true
  end
end
