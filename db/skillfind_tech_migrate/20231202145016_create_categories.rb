class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, :id => :uuid do |t|
      t.string :name, null: false
      t.string :en, null: false
      t.string :pl, null: false

      t.timestamps
    end
  end
end
