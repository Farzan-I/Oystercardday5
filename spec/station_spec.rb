require 'station'

describe Station do
  it "should know what zone it's in" do
    station = Station.new(:Maida_Vale, 2)
    expect(station.details).to eq({station_name: :Maida_Vale, zone: 2})
  end

end
