class RenameCitizenTableToMunipe < ActiveRecord::Migration[7.1]
  def change
    rename_table :citizens, :municipes
  end
end
