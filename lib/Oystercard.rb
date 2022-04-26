class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station
  attr_accessor :in_use

  def initialize
    @balance = 0
    @entry_station = nil
    @in_use = false

  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_use = true
  end
  
  def touch_in(entry_station)
    fail 'Insufficient funds' if balance < MINIMUM_CHARGE
    !@in_use
    @entry_station = entry_station
  end
  
  def touch_out # (entry_station)
    deduct(MINIMUM_CHARGE)
    @in_journey = false
    
  end

  private
  
  def deduct(amount)
    @balance -= amount  
  end


end