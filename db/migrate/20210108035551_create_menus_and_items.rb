class CreateMenusAndItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menus, id: :uuid do |t|
      t.timestamps
      t.belongs_to :place, null: false, type: :uuid, foreign_key: true
    end
    
    create_table :items, id: :uuid do |t|
      t.timestamps
      t.string :name
      t.string :description
      t.string :size
      t.string :image
      t.float  :price
    end
    add_index :items, :name
    
    create_join_table :menus, :items, table_name: :menu_items, column_options: {type: :uuid}
  end
end
