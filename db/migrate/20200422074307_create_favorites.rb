class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :like, foreign_key: { to_table: :houses }

      t.timestamps
      
    end
  end
end
