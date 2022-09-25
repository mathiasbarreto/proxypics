class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :status, default: "pending"
      t.string :photos

      t.timestamps
    end
  end
end
