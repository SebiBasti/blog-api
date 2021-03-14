class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.string :segment_type
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
