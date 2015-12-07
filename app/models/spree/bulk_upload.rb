require 'csv'
class Spree::BulkUpload < ActiveRecord::Base
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "text/csv" }
  after_commit :run_import, on: :create

  def finished?
    total_rows == processed_rows
  end

  def finish_percent
    if total_rows > 0
      (processed_rows / total_rows.to_f) * 100
    else
      100
    end
  end

  private

  def run_import
    uri = if ActionController::Base.asset_host.nil?
      self.attachment.path
    else
      URI.join(ActionController::Base.asset_host,self.attachment.url)
    end
    file = open(uri)
    csv_file = CSV.read(file, {headers: true})
    SpreeBulkUpload::ImportProcessor.new(csv_file, self).run
  end

end
