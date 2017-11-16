module RocketLeague
  class Configuration
    attr_writer :key, :verify_ssl

    def key
      @key
    end

    def verify_ssl
      @verify_ssl
    end
  end

  def self.configure(&block)
    block.call(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  module API
    include HTTParty
    extend self

    base_uri 'https://api.rocketleaguestats.com/v1'

    DEFAULT_MESSAGE ||= 'the RocketLeague module before using this gem. See the README.md for how to configure it'

    MISSING_CONFIGURATION ||= 'You must configure ' + DEFAULT_MESSAGE
    MISSING_KEY ||= "You must pass your 'key' to " + DEFAULT_MESSAGE

    attr_accessor :headers

    def request
      handle_response do
        raise MISSING_CONFIGURATION if RocketLeague.configuration.nil?
        raise MISSING_KEY if RocketLeague.configuration.key.nil?

        default_options.update(verify: RocketLeague.configuration.verify_ssl)

        @headers = {
          'Authorization' => RocketLeague.configuration.key
        }
      end
    end

    def handle_response(&block)
      yield
    rescue => e
      {
        success: false,
        code: 500,
        message: e.message
      }
    end

    def parse_get(url, query = nil)
      request = get(url, headers: headers, query: query)

      if request.success?
        begin
          RocketLeague::Util.transform_hash_keys(request.parsed_response)
        rescue
          raise 'There was a problem parsing the JSON. Most likely an API problem.'
        end
      else
        raise request.response
      end
    end

    def parse_post(url, query)
      raise NotImplemented

      request = post(url, headers: headers, query: query)
    end
  end
end
