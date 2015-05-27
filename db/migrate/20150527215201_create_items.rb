class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :url
      t.float :price
      t.text :comment
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
