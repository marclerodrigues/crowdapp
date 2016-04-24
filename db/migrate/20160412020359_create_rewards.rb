class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.text :name
      t.text :description
      t.decimal :value
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
