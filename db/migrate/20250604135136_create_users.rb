class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.text :biography, null: false

      t.timestamps
    end
  end
end
