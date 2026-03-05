class AddBuildingNameToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :building_name, :string
  end
end
