# frozen_string_literal: true

module RocketLeague::Data
  class Tier
    def initialize
    end

    def get
      RocketLeague::API.handle_response do
        RocketLeague::API.parse_get('/data/tiers')
      end
    end
  end
end