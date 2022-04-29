class Station 
  attr_reader :details

  def initialize(station_name, zone)
    @details = {station_name: station_name, zone: zone}
  end 

end