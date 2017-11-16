require 'rocketleague/version'
require 'httparty'

module RocketLeague
  Dir[File.dirname(__FILE__) + '/rocketleague/**/*.rb'].each do |file|
    require file
  end
end
