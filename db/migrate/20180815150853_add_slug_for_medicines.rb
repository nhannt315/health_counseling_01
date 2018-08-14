class AddSlugForMedicines < ActiveRecord::Migration[5.2]
  def change
    add_column :medicine_types, :slug, :string
    add_column :medicines, :slug, :string
  end
end
