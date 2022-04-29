class OysterCard
  attr_reader :balance, :journey_history
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
    @fare = MIN_FARE
    @journey_history = []
  end 

  def top_up(money)
    raise "Cannot exceed £#{MAX_BALANCE} balance" if max_balance_exceeded?(money)
    @balance += money
  end
  
  def in_journey?
    @in_use
  end 

  def touch_in(start_station)
    raise 'Balance insufficient' if balance_insufficient?
    @in_use = true
    start_journey(start_station)
  end

  def touch_out(end_station)
    deduct(fare)
    end_journey(end_station)
    @in_use = false
  end

  private

  attr_reader :fare, :travelled_from
  
  def start_journey(station)
    @travelled_from = station
  end

  def end_journey(station)
    journey_history << {start_station: "#{@travelled_from}".to_sym, end_station: "#{station}".to_sym}
  end

  def max_balance_exceeded?(money)
    balance + money > MAX_BALANCE
  end

  def balance_insufficient?
    balance < MIN_FARE
  end

  def deduct(fare)
    @balance -= fare
  end
  
end