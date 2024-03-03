class CreateCitizens < ActiveRecord::Migration[7.1]
  def change
    create_table :citizens do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.virtual :full_name, type: :string, as: "first_name || ' ' || last_name", stored: true
      t.string :cpf, null: false
      t.string :national_health_card, null: false
      t.string :email, null: false
      t.date :birth_date, null: false
      t.string :phone_number, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :citizens, :cpf, unique: true
    add_index :citizens, :national_health_card, unique: true
    add_index :citizens, :email, unique: true
  end
end
