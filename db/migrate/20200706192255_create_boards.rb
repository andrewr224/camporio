class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string  :name, null: false
      t.text    :description
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
