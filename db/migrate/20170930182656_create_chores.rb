class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :task
      t.date :due_date
      t.references :member, index: true

      t.timestamps null: false
    end
    add_foreign_key :chores, :members
  end
end
