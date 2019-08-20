class CreateUserAndTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :api_key, null: false
      t.integer :balance, default: 0, null: false
      t.timestamps
    end

    create_table :transactions do |t|
      t.belongs_to :user, index: true
      t.string :transfer_uid, index: true
      t.integer :amount, null: false
      t.string :category, null: false
      t.string :status, default: "pending", null: false
      t.timestamps
    end
  end
end
