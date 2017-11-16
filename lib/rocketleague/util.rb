module RocketLeague
  class Util
  
    class << self
      
      def parse_timestamp(timestamp)
        Time.at(timestamp)
      rescue
        nil
      end

      def transform_hash_keys(value)
        case value
        when Array
          value.map { |v| transform_hash_keys(v) }
        when Hash
          Hash[value.map { |k, v| [snake_case(k), transform_hash_keys(v)] }]
        else
          value
        end
      end

    private

      def snake_case(string)
        string
          .gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
          .gsub(/([a-z\d])([A-Z])/,'\1_\2')
          .tr("-", "_")
          .downcase
      end
    end
  end
end