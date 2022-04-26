class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station
  attr_accessor :in_use, :list_of_journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @list_of_journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    if entry_station != nil
      true
    end
  end
  
  def touch_in(entry_station)
    fail 'Insufficient funds' if balance < MINIMUM_CHARGE
    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @list_of_journeys << {"Journey:" => "#{@entry_station} -> #{exit_station}"}
    @entry_station = nil
  end

  private
  
  def deduct(amount)
    @balance -= amount  
  end


end