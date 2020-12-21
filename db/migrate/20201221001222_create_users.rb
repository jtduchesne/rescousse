class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.timestamps
      t.string :name
      t.string :email
    end
  end
end
