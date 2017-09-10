require "spec_helper"

RSpec.describe GemOutdated do
  describe "#outdated?" do
    include RubygemAPIHelpers

    it "tells latest version given outdated version" do
      stub_gem("rails")
      stub_latest_version("rails", "5.1.3")

      result = GemOutdated.outdated?("rails", "5.1.2")

      expect(result).to eq "5.1.3"
    end

    it "returns false given latest version" do
      stub_gem("rails")
      stub_latest_version("rails", "5.1.3")

      result = GemOutdated.outdated?("rails", "5.1.3")

      expect(result).to eq false
    end

    it "returns false given pre-release version" do
      stub_gem("rails")
      stub_latest_version("rails", "5.1.3")

      result = GemOutdated.outdated?("rails", "5.1.4.rc1")

      expect(result).to eq false
    end

    it "raises GemNotFound error given non-exist gem" do
      stub_gem_not_exists("thisgemdoesntexist")

      expect do
        GemOutdated.outdated?("thisgemdoesntexist", "1.0.0")
      end.to raise_error GemOutdated::RubygemsAPI::GemNotFound
    end

    it "raises false given non-exist version of a gem" do
      stub_gem("rails")
      stub_latest_version("rails", "5.1.3")

      result = GemOutdated.outdated?("rails", "9.9.9")

      expect(result).to eq false
    end
  end
end
