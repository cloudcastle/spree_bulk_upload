require 'csv'
class Spree::BulkUploadError < ActiveRecord::Base

  belongs_to :bulk_upload, class_name: 'Spree::BulkUpload'

end
