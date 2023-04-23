class ModifyPatients < ActiveRecord::Migration[6.1]
    def change
      remove_column :patients, :age, :integer
      add_column :patients, :first_name, :string
      add_column :patients, :last_name, :string
      add_column :patients, :diagnosis, :text
    end
  end