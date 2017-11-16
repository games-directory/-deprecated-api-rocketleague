require "spec_helper"

RSpec.describe Api::Rocketleague do
  it "has a version number" do
    expect(Api::Rocketleague::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
