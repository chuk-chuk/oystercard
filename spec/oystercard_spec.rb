require 'oystercard'

describe Oystercard do

  # let(:balance) { 200 }
  let(:default_balance) { 0 }
   subject(:oystercard) { described_class.new }

   it { is_expected.to respond_to(:balance) }

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq default_balance
  end
end
