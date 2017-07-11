require 'station'

describe Station do
  let(:name) { "Aldgate" }
  let(:zone) { 1 }
  subject(:station) { described_class.new(name, zone) }
  it 'should set a name' do
    expect(subject.name).to eq name
  end
  it 'should set a zone' do
    expect(subject.zone).to eq zone
  end
end
