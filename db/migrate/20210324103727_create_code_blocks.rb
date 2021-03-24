class CreateCodeBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :code_blocks do |t|
      t.string :code_type
      t.text :content
      t.references :segment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
