class AddCreatedByToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :created_by, :string
  end
end
