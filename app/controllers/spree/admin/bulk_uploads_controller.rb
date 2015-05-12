module Spree
  module Admin
    class BulkUploadsController < Spree::Admin::BaseController

      respond_to :html

      def index
        @bulk_uploads = Spree::BulkUpload.all
        respond_with @bulk_uploads
      end

      def new
        @bulk_upload = Spree::BulkUpload.new
        respond_with(@bulk_upload) do |format|
          format.html { render :layout => !request.xhr? }
          if request.xhr?
            format.js   { render :layout => false }
          end
        end
      end

      def create
        @bulk_upload = Spree::BulkUpload.create(upload_params)
        redirect_to admin_bulk_uploads_path
      end

      private

      def upload_params
        params.require(:bulk_upload).permit(:attachment)
      end
    end
  end
end