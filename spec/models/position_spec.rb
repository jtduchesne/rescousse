require 'rails_helper'

RSpec.describe Position, type: :model do
  #= Validations ================================================================#
  
  it 'requires an ip_address' do
    expect(FactoryBot.build(:position, ip_address: "")).to be_invalid
  end
  
  #= Attributes =================================================================#
  
  let(:position) { FactoryBot.build(:position) }
  
  describe '#ip_address' do
    subject { position.ip_address }
    it { is_expected.to be_an(IPAddr) }
  end
  
  describe '#city' do
    subject { position.city }
    it { is_expected.to be_a(String) }
  end
  describe '#province' do
    subject { position.province }
    it { is_expected.to be_a(String) }
  end
  describe '#country' do
    subject { position.country }
    it { is_expected.to be_a(String) }
  end
  
  describe '#latitude' do
    subject { position.latitude }
    it { is_expected.to be_a(Float) }
  end
  describe '#longitude' do
    subject { position.longitude }
    it { is_expected.to be_a(Float) }
  end
  
  describe '#lat' do
    subject { position.lat }
    it { is_expected.to be_a(Float) }
    it { is_expected.to eq position.latitude }
  end
  describe '#lng' do
    subject { position.lng }
    it { is_expected.to be_a(Float) }
    it { is_expected.to eq position.longitude }
  end
  
  describe '#count' do
    subject { position.count }
    it { is_expected.to be_an(Integer) }
  end
end
