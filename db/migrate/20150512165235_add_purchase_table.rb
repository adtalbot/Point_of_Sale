class AddPurchaseTable < ActiveRecord::Migration
  def change
    create_table(:purchases) do |t|
      t.column(:total, :decimal)

      t.timestamps
    end
  end
end
