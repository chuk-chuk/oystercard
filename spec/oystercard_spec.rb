require 'oystercard'

describe Oystercard do

  let(:bad_topup) { 120 }
  let(:default_balance) { 0 }
  let(:topup_value) { 50 }
  let(:spent_fare) { 5 }
  let(:max_limit) { Oystercard::LIMIT }
  subject(:oystercard) { described_class.new }

  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:top_up) }
  it { is_expected.to respond_to(:deduct) }

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq default_balance
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

end
