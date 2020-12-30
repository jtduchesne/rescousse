class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: true
      t.string     :name, null: false
    end
    add_index :roles, :name, unique: true
  end
end
