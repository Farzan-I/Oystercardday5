

class Journey
  attr_reader :travelled_from, :travelled_to, :complete

  PENALTY_FARE = 20
  MIN_FARE = 1

  def initialize
    @complete = false
  end

  def start(station)
    @travelled_from = station
  end

  def finish(station)
    @travelled_to = station
    @complete = true unless @travelled_from == nil 
  end

  def fare 
    @complete == true ? MIN_FARE : PENALTY_FARE
  end
end

