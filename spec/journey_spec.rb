require 'journey'

describe Journey do
  let(:test_start_station) { double :test_start_station }
  let(:test_end_station) { double :test_end_station }

  describe "#start" do
    it "check that the journey has started" do
        expect { subject.start(:test_start_station) }.to change(subject, :travelled_from).from(nil).to(:test_start_station)
    end

    it "check that touching in would not complete the journey" do
      expect { subject.start(:test_start_station) }.not_to change(subject, :complete)
    end


  end

  describe "#finish" do
    it "check that the journey records exit station" do
      expect { subject.finish(:test_end_station) }.to change(subject, :travelled_to).from(nil).to(:test_end_station)
    end

    it "check that touching out would not complete the journey" do
      expect { subject.finish(:test_end_station) }.not_to change(subject, :complete)
    end

    context "it starts a journey" do 
      before(:example) { subject.start(:test_start_station) }

      it "check that it can finish a journey" do
          expect { subject.finish(:test_end_station) }.to change(subject, :complete).from(false).to(true)
      end
    end
  end

  describe "#fare" do
    context "it starts a journey" do 
      before(:example) { subject.start(:test_start_station) }
        it "checks that the journey without a finish has a penalty fare" do
          expect(subject.fare).to eq Journey::PENALTY_FARE
        end

      context "it finishes a journey" do
        before(:example) { subject.finish(:test_end_station) }
          it "checks that the journey with a start and a finish has a normal fare" do
            expect(subject.fare).to eq Journey::MIN_FARE
          end
      end

    end
    
    context "it only finishes a journey" do
      before(:example) { subject.finish(:test_end_station) }
        it "checks that the journey without a start has a penalty fare" do
          expect(subject.fare).to eq Journey::PENALTY_FARE
        end
    
    end
  end
    
end

# TO DO:
# make it work together with oystercard
# 


# DONE:
# touch in, no touch out
# touch in, touch out
# no touch in, touch out --> penalty fare


# Journey.fare ---> Give us the fare (£penalty or £normal)