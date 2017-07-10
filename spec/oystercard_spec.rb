require 'oystercard'

describe Oystercard do

  let(:default_balance) { 0 }
  let(:topup_value) {50}
   subject(:oystercard) { described_class.new }

   it { is_expected.to respond_to(:balance) }
   it { is_expected.to respond_to(:top_up) }

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq default_balance
  end

  it "allows a card to be topped up" do
    expect { oystercard.top_up(topup_value) }.to change{ oystercard.balance }.by topup_value
  end

end
