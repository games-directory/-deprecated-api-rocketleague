# frozen_string_literal: true

module RocketLeague::Data
  class Playlist
    def initialize
    end

    def get
      RocketLeague::API.handle_response do
        RocketLeague::API.parse_get('/data/playlists')
      end
    end
  end
end