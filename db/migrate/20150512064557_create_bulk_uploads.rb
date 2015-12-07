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

    create_table :spree_bulk_upload_errors do |t|
      t.integer :bulk_upload_id
      t.string  :error_message
      t.text    :raw_data
      t.timestamps
    end

    add_index :spree_bulk_upload_errors, :bulk_upload_id

  end
end
