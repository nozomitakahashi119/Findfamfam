class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :place
      t.string :room_size
      t.string :rent
      t.string :gender
      t.string :special_notes

      t.timestamps
    end
  end
end
