class Oystercard 
  LIMIT = 90
  attr_reader :balance, :entry_station, :exit_station, :journeys
  MINIMUM_BALANCE = 1 

  def initialize 
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "maximum limit of #{LIMIT} exceeded" if @balance + amount > 90 
    @balance += amount 
  end

  def touch_in(entry_station)
    fail 'Insufficient funds' if insufficient_funds?
    @entry_station = entry_station
  end 

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    add_journey
    @entry_station = nil 
  end 

  def insufficient_funds? 
    @balance < MINIMUM_BALANCE 
  end 

  def in_journey?
    !!@entry_station
  end 

private 

  def deduct(fare)
    @balance -= fare 
  end 

  def add_journey
    @journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end
end
