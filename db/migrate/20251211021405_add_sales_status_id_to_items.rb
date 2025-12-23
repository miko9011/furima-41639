class AddSalesStatusIdToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :sales_status_id, :integer
  end
end
