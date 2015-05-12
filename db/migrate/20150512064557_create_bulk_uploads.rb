class CreateBulkUploads < ActiveRecord::Migration
  def change
    create_table :spree_bulk_uploads do |t|
      t.string   :attachment_content_type, :attachment_file_name
      t.datetime :attachment_updated_at
      t.integer  :attachment_size
      t.integer :total_rows, default: 0, null: false
      t.integer :processed_rows, default: 0, null: false

      t.timestamps
    end
  end
end
