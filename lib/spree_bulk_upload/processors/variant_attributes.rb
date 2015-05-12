module SpreeBulkUpload
  module Processors
    class VariantAttributes < Base
      attr_reader :variant_row

      def initialize(variant_row)
        @variant_row = variant_row
      end


      protected

      def attributes_mapping
        {
            'SKU' => 'sku',
            'Cost' => 'cost_price'
        }
      end

      def source_object
        variant_row
      end

    end
  end
end