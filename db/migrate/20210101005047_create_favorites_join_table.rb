class CreateFavoritesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :places, table_name: :favorites, column_options: {type: :uuid}
  end
end
