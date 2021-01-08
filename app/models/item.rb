class Item < ApplicationRecord
  validates_presence_of :name, :image
  
  has_and_belongs_to_many :menus, join_table: "menu_items"
end
