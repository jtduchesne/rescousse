class CreateDefaultMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :default_menus, id: :uuid do |t|
      t.timestamps
    end
    
    create_join_table :default_menus, :items, table_name: :default_menu_items, column_options: {type: :uuid}
    
    reversible do |dir|
      dir.up do
        menu = DefaultMenu.create!
        menu.items.create!(name: "Pinte", description: "Pinte de bière", size: "500ml", price: 10, image: "Pinte")
        menu.items.create!(name: "Verre", description: "Verre de bière", size: "300ml", price:  7, image: "Verre")
        menu.items.create!(name: "Shooter", description: "Shooter",      size:  "33ml", price:  4, image: "Shooter")
        
        Place.find_each do |place|
          place.create_menu!(items: menu.items)
        end
      end
      dir.down do
        DefaultMenu.find_each do |menu|
          items = menu.items
          menu.items.clear
          items.each(&:destroy)
        end
      end
    end
  end
end
