# frozen_string_literal: true

module RocketLeague::Data
  class Platform
    attr_accessor :platform

    def initialize(platform)
      @platform = platform
    end

    def get
      return unless ['steam', 'ps4', 'xbox'].include?(platform)
      self.send(platform)
    end

  private

    def steam
      { 'id' => 1, 'name' => 'Steam' }
    end

    def ps4
      { 'id' => 2, 'name' => 'Ps4' }
    end

    def xbox
      { 'id' => 3, 'name' => 'XboxOne' }
    end
  end
end