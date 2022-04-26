require 'station'

describe Station do

  subject {decribed_class.new(name: "Southwark", zone: 1)}
  

  it "Show the name of the current station" do
    expect(subject.name).to eq("Southwark")
  end

  it "Show the zone of the current station" do
    expect(subject.zone).to eq(1)
  end

end