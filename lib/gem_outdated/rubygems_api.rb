# frozen_string_literal: true

require "http"

class GemOutdated
  class RubygemsAPI
    GemNotFound = Class.new(RuntimeError)
    GemVersionNotFound = Class.new(RuntimeError)

    def initialize(gem_name)
      @gem_name = gem_name

      gem_exists?
    end

    def latest_version
      endpoint = File.join(API_ENDPOINT, "versions", gem_name, "latest.json")
      HTTP.get(endpoint).parse["version"]
    end

    private
    attr_reader :gem_name

    API_ENDPOINT = "https://rubygems.org/api/v1"

    def gem_exists?
      endpoint = File.join(API_ENDPOINT, "gems", "#{gem_name}.json")
      code = HTTP.get(endpoint).code
      code == 404 ? raise(GemNotFound) : true
    end
  end
end
