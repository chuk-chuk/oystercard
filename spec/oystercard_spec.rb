require './lib/oystercard'

describe Oystercard do

  let(:bad_topup) { 120 }
  let(:default_balance) { 0 }
  let(:topup_value) { 50 }
  let(:min_fare) { described_class::MIN_BALANCE }
  let(:max_limit) { described_class::LIMIT }
  let(:penalty_fare) { described_class::PENALTY_FARE }
  let(:station1) { double :station1 }
  let(:exit_station) { double :exit_station}
  let(:journey) { {entry_station: station1, exit_station: exit_station} }
  subject(:oystercard) { described_class.new }

  context "initial state of the card" do
    it "has a default balance of 0" do
      expect(oystercard.balance).to eq default_balance
    end
    it 'is initially not in a journey' do
      expect(oystercard.in_journey?).not_to eq true
    end
    it "journeys history is empty" do
      expect(oystercard.history).to be_empty
    end
  end

  it "raises error if touched in without minimum balance on card" do
    expect { oystercard.touch_in(station1) }.to raise_error "Touch in failed, balance lower than minimum"
  end

  it "allows a card to be topped up" do
    expect { oystercard.top_up(topup_value) }.to change { oystercard.balance }.by topup_value
  end

  it "raises an error if the card is topped up over the maximum limit" do
    expect { oystercard.top_up(bad_topup) }.to raise_error("Sorry, the maximum amount is £#{ max_limit }")
  end

  context "require the card to be topped up" do
    before :each { oystercard.top_up(max_limit) }

    context "#touch_in" do
      before :each { oystercard.touch_in(station1) }
      it "stores the entry_station" do
        expect(oystercard.journey.entry_station).to eq station1
      end
      it "tracks that the card is in use, touched in" do
        expect(oystercard).to be_in_journey
      end
    end

    context "touch out" do
      it "deducts the penalty fare for jorney" do
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -penalty_fare
      end
    end

    context "complete journey" do
      before :each do
        oystercard.touch_in(station1)
        oystercard.touch_out(exit_station)
      end
      it "checks if journey was added" do
        expect(oystercard.history.count).to eq 1
      end
      it "deducts the min fare for jorney" do
        expect(oystercard.balance).to eq(max_limit - min_fare)
      end
    end
  end

end
