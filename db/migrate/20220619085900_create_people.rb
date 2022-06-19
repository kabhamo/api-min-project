class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :favoriteProgrammingLanguage
      t.integer :activeTaskCount, :default => 0
    end
  end
end
