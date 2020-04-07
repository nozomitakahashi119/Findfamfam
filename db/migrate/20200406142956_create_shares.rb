class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.references :user, foreign_key: true
      t.references :house, foreign_key: true
      t.boolean :ok_request, default: false, null: false

      t.timestamps
    end
  end
end
