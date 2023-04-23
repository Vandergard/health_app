class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.text :contact_info
      t.text :medical_info
      t.text :notes

      t.timestamps
    end
  end
end
