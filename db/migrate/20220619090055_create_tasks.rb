class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :owner, null: false, foreign_key: { to_table: :people }
      t.string :type
      t.string :status
      t.string :description
      t.string :size
      t.string :course
      t.date :dueDate
      t.string :details
    end
  end
end
