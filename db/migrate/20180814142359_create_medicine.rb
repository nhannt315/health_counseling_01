class CreateMedicine < ActiveRecord::Migration[5.2]
  def change
    create_table :medicine_classes do |t|
      t.string :name
    end
    create_table :medicine_types do |t|
      t.string :name
      t.references :medicine_class, foreign_key: true
    end
    create_table :medicines do |t|
      t.string :name
      t.string :image
      t.references :medicine_type, foreign_key: true
      t.string :company
      t.text :overview
      t.text :instruction
      t.text :info
      t.text :warning
      t.text :contraindication
      t.text :side_effect
      t.text :note
      t.text :overdose
      t.text :preservation
    end
  end
end
