class CreateTextBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :text_blocks do |t|
      t.text :content
      t.references :segment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
