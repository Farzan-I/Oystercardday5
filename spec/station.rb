require 'station'

describe Station do
  

  it "Check the name of the station" do
    station = Station.new
    expect(subject.name).to eq(name)
  end

  it "Shows the zones that the oystercard has been used in" do

    expect(subject.zone).to eq(zone)
  end

end