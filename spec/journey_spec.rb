require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { "Bank" }
  let(:exit_station) { "Aldgate" }
  let(:min_fare) { described_class::MIN_FARE }
  let(:penalty_fare) { described_class::PENALTY_FARE }

  context 'touch in and out' do
    it 'should return minimum fare' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq min_fare
    end
  end

  context 'touch in but not out' do
    it 'should return minimum fare' do
      journey.start(entry_station)
      expect(journey.fare).to eq penalty_fare
    end
  end

end
