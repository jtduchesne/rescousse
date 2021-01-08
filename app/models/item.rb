class Item < ApplicationRecord
  validates_presence_of :name, :image
  
  has_and_belongs_to_many :menus, join_table: "menu_items"
  has_and_belongs_to_many :default_menus, join_table: "default_menu_items"
  
  before_validation :readonly!, if: -> { default_menus.any? }, on: :update
  before_destroy    :readonly!, if: -> { default_menus.any? }
  
  def readonly?
    readonly! if persisted? && default_menus.any?
    super
  end
  
  def default?
    DefaultMenu.current.items.exists?(self.id)
  end
end
