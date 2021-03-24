class CreateYoutubeLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :youtube_links do |t|
      t.string :link
      t.references :segment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
