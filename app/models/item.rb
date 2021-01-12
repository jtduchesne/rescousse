class Item < ApplicationRecord
  validate  :name_present_in_both_languages
  validates :image, presence: true
  
  has_and_belongs_to_many :menus, join_table: "menu_items"
  has_and_belongs_to_many :default_menus, join_table: "default_menu_items"
  
  before_validation :readonly!, if: -> { default_menus.any? }, on: :update
  before_destroy    :readonly!, if: -> { default_menus.any? }
  
  serialize :name, JSON
  def name
    super.with_indifferent_access rescue name_before_type_cast
  end
  def name=(value)
    if value.is_a?(Hash)
      super(value.symbolize_keys.slice(*I18n.available_locales))
    else
      super({ fr: value, en: value })
    end
  end
  
  serialize :description, JSON
  def description
    super.with_indifferent_access rescue description_before_type_cast
  end
  def description=(value)
    if value.is_a?(Hash)
      super(value.symbolize_keys.slice(*I18n.available_locales))
    else
      super({ fr: value, en: value })
    end
  end
  
  def readonly?
    readonly! if persisted? && default_menus.any?
    super
  end
  
  def default?
    DefaultMenu.current.items.exists?(self.id)
  end
  
private
  def name_present_in_both_languages
    if name[:fr].blank? || name[:en].blank?
      errors.add(:name, :blank)
    end
  end
end
