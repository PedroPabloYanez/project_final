class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :status, default: 0
      t.date :due_date
      t.string :priority
      t.references :project

      t.timestamps
    end
  end
end
