require "spec_helper"

RSpec.describe GemOutdated do
  it "has a version number" do
    expect(GemOutdated::VERSION).not_to be nil
  end
end
