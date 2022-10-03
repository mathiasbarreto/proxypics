class CreateRequesters < ActiveRecord::Migration[7.0]
  def change
    create_table :requesters do |t|
      t.string :name
      t.string :api_key

      t.timestamps
    end
  end
end
