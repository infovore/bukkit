class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :content
      t.timestamp :delivered_at
      t.references :account
      t.timestamps
    end
    add_index :items, :account_id
  end
end
