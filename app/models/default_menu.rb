class DefaultMenu < ApplicationRecord
  has_and_belongs_to_many :items, -> { readonly }, join_table: "default_menu_items"
  
  default_scope -> { includes(:items) }
  
  def self.current
    self.order(:created_at).last
  end
end
