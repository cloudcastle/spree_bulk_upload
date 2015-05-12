module SpreeBulkUpload
  module Processors
    class Base

      def get_attributes
        {}.tap do |attrs|
          attributes_mapping.each do |k, v|
            case v
              when String
                attrs[v] = source_object[k]
              when Hash
                attrs[v[:attr]] = v[:value].call(source_object[k])
            end
          end
        end
      end

      protected

      def attributes_mapping
        raise NotImplementedError
      end

      def source_object
        raise NotImplementedError
      end

    end
  end
end