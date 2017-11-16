# frozen_string_literal: true

module RocketLeague
  class Player
    INVALID_IDENTITY_ID ||="'unique_id' parameter needs to be a String"
    INVALID_PLATFORM_ID ||="'platform_id' parameter needs to be either a Hash, String or Integer"
    INVALID_DISPLAY_NAME ||="'display_name' parameter needs to be a String"

    def initialize
    end

    def profile(unique_id, platform)
      raise ArgumentError, INVALID_IDENTITY_ID unless unique_id.is_a?(String)

      case platform.class.to_s
      when 'Hash'
        platform_id = platform['id']
      when 'String'
        platform_id = RocketLeague::Data::Platform.new(platform).get()['id']
      when 'Integer'
        platform_id = platform
      else
        raise ArgumentError, INVALID_PLATFORM_ID
      end

      RocketLeague::API.handle_response do
        query = {
          unique_id: unique_id,
          platform_id: platform_id
        }

        RocketLeague::API.parse_get('/player', query)
      end
    end

    def bulk(profiles)
      RocketLeague::API.handle_response do
        RocketLeague::API.parse_post('/player/batch', profiles)
      end
    end

    def search(display_name, page = 0)
      raise ArgumentError, INVALID_DISPLAY_NAME unless display_name.is_a?(String)

      RocketLeague::API.handle_response do
        query = {
          display_name: display_name
        }

        RocketLeague::API.parse_get('/search/players', query)
      end
    end
  end
end