class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :status, default: 0
      t.date :initial_date
      t.date :finish
      t.references :team

      t.timestamps
    end
  end
end
