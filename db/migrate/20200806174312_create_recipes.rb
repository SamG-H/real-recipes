class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :cook_time
      t.string :ingredients
      t.string :tags
      t.string :link
    end
  end
end
