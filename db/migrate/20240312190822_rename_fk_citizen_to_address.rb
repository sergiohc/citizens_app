class RenameFkCitizenToAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :citizen_id, :municipe_id
  end
end
