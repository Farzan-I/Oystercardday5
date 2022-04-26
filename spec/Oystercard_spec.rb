require 'Oystercard'

describe Oystercard do

    let(:entry_station) { double :entry_station }

    it "checks oystercard has a balance" do
        oystercard = Oystercard.new
        expect(subject.balance).to eq(0)
    end

    describe '#top_up' do
        it "can be able to top-up oystercard balance" do
            expect(subject).to respond_to(:top_up).with(1).argument
        end

        it "can top up balance" do
            expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
        end
    end

    it "raises an error if over top up limit" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

    describe '#deduct' do
        it "deducts money from oystercard" do
            expect{ subject.touch_out }.to change{ subject.balance }.by(-1)
        end
    end
    
    it "checks oyster card is in journey" do

        subject.top_up(1)
        subject.touch_in(:entry_station)
        expect(subject.in_journey?).to eq true
    end

    it "checks oystercard is touched in" do
        subject.balance
        subject.top_up(1)
        subject.touch_in(:entry_station)
        expect(subject.in_journey?).to eq(true)
    end

    it "expects the card to remember the entry station after touch in" do
        
        subject.top_up(1)
        subject.touch_in("olympia")
        expect(subject.entry_station).to eq "olympia"

    end

    it "checks oystercard is touched out" do
        subject.balance
        subject.top_up(1)
        subject.touch_in(:entry_station)
        expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it "oystercard balance is insufficient and can't touch in" do
        subject.balance < 1
        expect{ subject.touch_in(:entry_station) }.to raise_error "Insufficient funds"
    end

    it "Charges the oystercard on touch out" do
        expect { subject.touch_out }.to change{ subject.balance }.by(-1)
    end



end