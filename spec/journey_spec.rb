require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { "Bank" }
  let(:exit_station) { "Aldgate" }
  let(:min_fare) { described_class::MIN_FARE }
  let(:penalty_fare) { described_class::PENALTY_FARE }

  context 'touch in and out' do
    before do
      journey.start(entry_station)
      journey.finish(exit_station)
    end
    it 'should return minimum fare' do
      expect(journey.fare).to eq min_fare
    end
    it 'complete? should be true' do
      expect(journey.complete?).to eq true
    end
  end

  context 'touch in but not out' do
    before { journey.start(entry_station) }
    it 'should be false during journey' do
      expect(journey.complete?).to eq false
    end
    it 'should return minimum fare' do
      expect(journey.fare).to eq penalty_fare
    end
  end

end
