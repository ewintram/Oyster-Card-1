require 'station'

describe Station do

  subject {described_class.new("Bank", 1)}

  describe "#initialize" do

    it "initializes with a name" do
      expect(subject.station_name).to eq("Bank")
    end

    it "initializes with a zone" do
      expect(subject.station_zone).to eq 1
    end
  end

end
