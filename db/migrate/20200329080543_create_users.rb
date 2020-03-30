class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :age
      t.string :gender
      t.string :income
      t.string :hobby
      t.string :special_notes

      t.timestamps
    end
  end
end
