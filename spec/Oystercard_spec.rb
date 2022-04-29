require 'oystercard'

describe OysterCard do
  max_balance = OysterCard::MAX_BALANCE

  it 'should have a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'should top up by money' do
      expect { subject.top_up(max_balance) }.to change(subject, :balance).by(max_balance)    
    end

    it 'should not allow balance to be topped up above maximum balance' do
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error "Cannot exceed £#{max_balance} balance"
    end 
  end

  describe '#touch_in' do
    context 'when the balance is below the minimum fare' do
      it 'should not allow the user to touch in' do
        expect { subject.touch_in(:test_start_station) }.to raise_error "Balance insufficient"
      end
    end
  end

  describe '#touch_out' do
    before(:example) do
      subject.top_up(max_balance) 
      subject.touch_in(:test_start_station)
    end

    it 'deducts correct amount from card at end of journey' do
      expect { subject.touch_out(:test_end_station)}.to change(subject, :balance).by(-OysterCard::MIN_FARE)
    end
    it 'can store previous trips' do
      expect { subject.touch_out(:test_end_station) }.to change(subject, :journey_history).from([]).to([{start_station: :test_start_station, end_station: :test_end_station}])
    end
  end

  describe '#test_start_station' do
    before(:example) { subject.top_up(max_balance) }
    let(:test_start_station) {double :station}
    let(:test_end_station) {double :station}
    
    it 'knows when it is on a journey' do
      expect { subject.touch_in(:test_start_station) }.to change(subject, :in_journey?).to true
    end

    it 'should return the station travelled from' do
      expect { subject.touch_in(:test_start_station) }.to change(subject, :travelled_from).from(nil).to(:test_start_station)
    end
  end

end