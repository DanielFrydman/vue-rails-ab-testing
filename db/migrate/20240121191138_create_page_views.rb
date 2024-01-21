class CreatePageViews < ActiveRecord::Migration[7.1]
  def change
    create_table :page_views do |t|
      t.string :user_id, null: false
      t.string :url, null: false
      t.string :displayed_text_variation, null: false
      t.timestamps
    end
  end
end
