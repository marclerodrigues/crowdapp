class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :name
      t.text :description
      t.decimal :goal
      t.text :image
      t.text :video
      t.datetime :expiration_data
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
