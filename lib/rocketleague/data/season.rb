# frozen_string_literal: true

module RocketLeague::Data
  class Season
    def initialize
    end

    def get
      RocketLeague::API.handle_response do
        RocketLeague::API.parse_get('/data/seasons')
      end
    end
  end
end