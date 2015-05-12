module SpreeBulkUpload
  class ImportProcessor
    attr_reader :csv_file

    def initialize(csv_file)
      @csv_file = csv_file
    end

    def run
      ActiveRecord::Base.transaction do
        grouped_products.each do |product_sku, variants|
          process_product(product_sku, variants)
        end
      end
    end

    protected

    def group_value
      'Parent product (SKU)'
    end

    private

    def grouped_products
      csv_file.group_by { |line| line[group_value] }
    end


    def process_product(master_sku, variants)
      product = Spree::Product.joins(:master).
          where(Spree::Variant.arel_table[:sku].eq(master_sku)).first || Spree::Product.new
      product_attributes = Processors::ProductAttributes.new(master_sku, variants).get_attributes
      product.assign_attributes(product_attributes)
      product.save!

      variants.each do |v|
        variant = Spree::Variant.find_or_initialize_by(sku: v['SKU'])
        variant_attributes = Processors::VariantAttributes.new(v).get_attributes
        variant.assign_attributes(variant_attributes)
        variant.product = product
        variant.save!
      end
    end



  end
end