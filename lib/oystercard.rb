class Oystercard 
  LIMIT = 90
  attr_reader :balance 
  attr_accessor :in_journey
  MINIMUM_BALANCE = 1 

  def initialize 
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "maximum limit of #{LIMIT} exceeded" if @balance + amount > 90 
    @balance += amount 
  end 
  
  def in_journey?
    @in_journey 
  end 

  def touch_in
    fail 'Insufficient funds' if insufficient_funds?
    @in_journey = true 
  end 

  def touch_out
    @in_journey = false
    deduct(MINIMUM_BALANCE)
  end 

  def insufficient_funds? 
    @balance < MINIMUM_BALANCE 
  end 

private 

  def deduct(fare)
    @balance -= fare 
  end 

end
