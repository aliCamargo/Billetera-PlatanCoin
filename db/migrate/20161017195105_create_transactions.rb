class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.text :description
      t.integer :amount, default: 0
      t.integer :instruction, default: 0

      t.timestamps
    end
  end
end
