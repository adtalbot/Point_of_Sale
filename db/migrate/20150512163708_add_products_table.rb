class AddProductsTable < ActiveRecord::Migration
  def change
    create_table(:products) do |t|
      t.column(:name, :string)
      t.column(:price, :decimal)
      t.column(:purchase_id, :integer)

      t.timestamps()
    end
  end
end
