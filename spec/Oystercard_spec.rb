require 'oystercard'

describe Oystercard do 
  
  it 'checks whether the balance is zero' do
    expect(subject.balance).to eq (0)
  end
  
  it 'adds money' do
    subject.top_up(50)
    expect(subject.balance).to eq (50)
  end

  it 'raises an error if we top up more than £90' do 
    limit = Oystercard::LIMIT
    subject.top_up(limit)
    expect {subject.top_up 1 }.to raise_error "maximum limit of #{limit} exceeded"
  end 

  it 'reduces the balance when we spend money using the method deduct' do 
    subject.top_up(50)
    subject.deduct(4.25) 
    expect(subject.balance).to eq (45.75)
  end 

  it 'Makes sure a new card is not in journey' do
    expect(subject.in_journey).to eq (false)
  end

  it 'changes the attribute in_journey to true after touching in' do 
   subject.touch_in 
   expect(subject.in_journey).to eq (true)
  end 

  it 'changes the attribute in_jouney to be false after touching in then out' do 
    subject.touch_in 
    subject.touch_out
    expect(subject.in_journey?).to eq false
   end 
   
end 
