require 'rails_helper'

RSpec.describe Position, type: :model do
  #= Validations ================================================================#
  
  it 'requires an ip_address' do
    expect(FactoryBot.build(:position, ip_address: "")).to be_invalid
  end
  
  #= Behaviors ==================================================================#
  
  context 'on creation' do
    let(:response) { {status: 500} }
    let!(:stub) { stub_request(:get, /api.ipgeolocation.io/).to_return(response) }
    
    subject { position.save! }
    
    it 'calls the API' do
      subject
      expect(stub).to have_been_requested
    end
    
    context 'when response is valid' do
      let(:hash)     { FactoryBot.create(:geolocation_hash) }
      let(:response) { {status: 200, body: hash.to_json} }
      
      it 'sets #city' do
        expect{ subject }.to change{ position.city }.to(hash[:city])
      end
      it 'sets #province' do
        expect{ subject }.to change{ position.province }.to(hash[:state_prov])
      end
      it 'sets #country' do
        expect{ subject }.to change{ position.country }.to(hash[:country_name])
      end
    
      it 'sets #latitude' do
        expect{ subject }.to change{ position.latitude }.to(hash[:latitude])
      end
      it 'sets #longitude' do
        expect{ subject }.to change{ position.longitude }.to(hash[:longitude])
      end
    end
    context 'when response is invalid' do
      let(:response) { {status: 423, body: "Whatever".to_json} }
      
      it 'clears #city' do
        expect{ subject }.to change{ position.city }.to("-")
      end
      it 'clears #province' do
        expect{ subject }.to change{ position.province }.to("-")
      end
      it 'clears #country' do
        expect{ subject }.to change{ position.country }.to("-")
      end
    
      it 'sets #latitude to a predefined value' do
        expect{ subject }.to change{ position.latitude }.to(47.0707212)
      end
      it 'sets #longitude to a predefined value' do
        expect{ subject }.to change{ position.longitude }.to(-70.5677533)
      end
    end
  end
  
  context 'on load' do
    let(:hash)     { FactoryBot.create(:geolocation_hash) }
    let(:response) { {status: 200, body: hash.to_json} }
    
    let!(:stub)     { stub_request(:get, /api.ipgeolocation.io/).to_return(response) }
    let!(:position) { FactoryBot.create(:position) }
    
    subject { Position.find_by!(ip_address: position.ip_address) }
    
    it 'does not call the API' do
      WebMock.reset!
      expect(subject).to eq position
      expect(stub).not_to have_been_requested
    end
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
