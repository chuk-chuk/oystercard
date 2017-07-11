require './lib/oystercard'

describe Oystercard do

  let(:bad_topup) { 120 }
  let(:default_balance) { 0 }
  let(:topup_value) { 50 }
  let(:spent_fare) { 5 }
  let(:max_limit) { described_class::LIMIT }
  subject(:oystercard) { described_class.new }

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq default_balance
  end

  it "raises error if touched in without minimum balance on card" do
    expect { oystercard.touch_in }.to raise_error "Touch in failed, balance lower than minimum"
  end

  it "allows a card to be topped up" do
    expect { oystercard.top_up(topup_value) }.to change { oystercard.balance }.by topup_value
  end

  it "raises an error if the card is topped up over the maximum limit" do
    expect { oystercard.top_up(bad_topup) }.to raise_error("Sorry, the maximum amount is £#{ max_limit }")
  end

  it "deducts the fare for jorney" do
    oystercard.top_up(topup_value)
    expect { oystercard.deduct(spent_fare) }.to change { oystercard.balance }.by -spent_fare
  end

  it 'is initially not in a journey' do
    expect(oystercard).not_to be_in_journey
  end

  context "require the card to be topped up" do
    before :each { oystercard.top_up(max_limit) }

    it "tracks that the card is in use, touched in" do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "tracks that the card is not longer in use, touched out" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

end
