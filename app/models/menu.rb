class Menu < ApplicationRecord
  belongs_to :place
  has_and_belongs_to_many :items, join_table: "menu_items"
end
