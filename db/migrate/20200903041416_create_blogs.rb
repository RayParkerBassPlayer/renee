class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.references :user
      t.timestamps
      t.string :title
      t.string :body
    end
  end
end
