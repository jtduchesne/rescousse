json.(item, :name, :description)
json.(item, :price) if item.price && (item.price > 0.0)
