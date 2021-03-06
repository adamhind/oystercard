require 'oystercard'

describe Oystercard do 
  
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'checks whether the balance begins at zero' do
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

  it 'Makes sure a new card is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'changes the attribute in_journey to true after touching in' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
   expect(subject).to be_in_journey
  end 

  it 'changes the attribute in_jouney to be false after touching in then out' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
   end 

  it 'raises an error if there is not at least £1 on the card when touching in' do 
    subject.top_up(0.50)
    expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds'
  end 

  it 'deducts from the card balance when touching out after touching in' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
    expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
  end 

  it 'stores the entry station when touching in.' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq (entry_station)
  end 

  it 'stores a journey when you touch in and out of a station.' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq (exit_station)
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  
  it 'stores journeys in a hash to be accessed later' do 
    subject.top_up(50)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

end 
