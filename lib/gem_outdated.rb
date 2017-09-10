# frozen_string_literal: true

require_relative "gem_outdated/version"
require_relative "gem_outdated/rubygems_api"

class GemOutdated
  def self.outdated?(gem_name, version)
    new(gem_name, version).outdated?
  end

  def initialize(gem_name, version)
    @gem_name = gem_name
    @version = version
  end

  def outdated?
    if gem_is_outdated?
      latest_version
    else
      false
    end
  end

  private
  attr_reader :gem_name, :version

  def latest_version
    @_latest_version ||= RubygemsAPI.new(gem_name).latest_version
  end

  def gem_is_outdated?
    Gem::Version.new(latest_version) > Gem::Version.new(version)
  end
end
