json.extract! @place, :name, :address, :hood, :city, :province, :fsa, :latitude, :longitude
json.menu @items, partial: 'item', as: :item
