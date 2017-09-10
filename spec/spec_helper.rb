require "bundler/setup"
require "gem_outdated"

# RSpec 3.6 configurations
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  # config.profile_examples = 10
end

require "webmock/rspec"

module RubygemAPIHelpers
  def rubygems_api_url
    "https://rubygems.org/api/v1"
  end

  def request_headers
    { "Host" => "rubygems.org" }
  end

  def json_headers
    { "Content-Type" => "application/json" }
  end

  def stub_gem(name)
    stub_request(:get, "#{rubygems_api_url}/gems/#{name}.json").with(
      headers: request_headers
    ).to_return(
      status: 200,
      headers: json_headers,
      body: { "name": name }.to_json
    )
  end

  def stub_latest_version(name, latest_version)
    stub_request(:get, "#{rubygems_api_url}/versions/#{name}/latest.json").with(
      headers: request_headers
    ).to_return(
      status: 200,
      headers: json_headers,
      body: { "version": latest_version }.to_json
    )
  end

  def stub_gem_not_exists(name)
    stub_request(:get, "#{rubygems_api_url}/gems/#{name}.json").with(
      headers: request_headers
    ).to_return(
      status: 404,
      headers: json_headers,
      body: "This rubygem could not be found."
    )
  end
end
