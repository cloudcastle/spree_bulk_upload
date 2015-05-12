require 'csv'
class Spree::BulkUpload < ActiveRecord::Base
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "text/csv" }
  after_commit :run_import, on: :create

  private

  def run_import
    file = open(self.attachment.url).read
    csv_file = CSV.read(file, {headers: true})
    SpreeBulkUpload::ImportProcessor.new(csv_file)
  end

end
