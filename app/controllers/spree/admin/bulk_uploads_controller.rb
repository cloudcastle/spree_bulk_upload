module Spree
  module Admin
    class BulkUploadsController < Spree::Admin::BaseController

      respond_to :html

      def index
        @bulk_uploads = Spree::BulkUpload.all
        respond_with @bulk_uploads
      end

      def create
        @bulk_upload = Spree::BulkUpload.create(upload_params)
        respond_with @bulk_upload
      end

      private

      def upload_params
        params.require(:bulk_upload).permit(:attachment)
      end
    end
  end
end