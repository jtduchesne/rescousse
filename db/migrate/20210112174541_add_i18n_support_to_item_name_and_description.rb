class AddI18nSupportToItemNameAndDescription < ActiveRecord::Migration[6.0]
  def up
    say_with_time "Converting Item.name and Item.description to JSON" do
      Item.find_each do |item|
        next if item.name.is_a?(Hash)
        
        case item.name
        when "Pinte"
          item.update_columns(name:        {fr: 'Pinte', en: 'Pint'},
                              description: {fr: 'Pinte de bière', en: 'Pint of beer'})
        when "Verre"
          item.update_columns(name:        {fr: 'Verre', en: "Glass"},
                              description: {fr: 'Verre de bière', en: 'Glass of beer'})
        when "Shooter"
          item.update_columns(name:        {fr: 'Shooter', en: 'Shooter'},
                              description: {fr: '', en: ''})
        else
          item.update_columns(name:        {fr: item.name, en: item.name},
                              description: {fr: item.description, en: item.description})
        end
      end
    end
  end
end
