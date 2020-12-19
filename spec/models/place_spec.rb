require 'rails_helper'

RSpec.describe Place, type: :model do
  #= Validations ================================================================#
  
  it 'requires a name' do
    expect(FactoryBot.build(:place, name: "")).to be_invalid
  end
  it 'requires a unique name per city' do
    name = "not unique"
    FactoryBot.create(:place, name: name, city: name)
    expect(FactoryBot.build(:place, name: name)).to be_valid
    expect(FactoryBot.build(:place, name: name, city: name)).to be_invalid
  end
  
  it 'requires province to be "QC"' do
    expect(FactoryBot.build(:place, province: "ON")).to be_invalid
  end
  it 'requires country to be "CA"' do
    expect(FactoryBot.build(:place, country: "US")).to be_invalid
  end
  
  it 'requires a latitude' do
    expect(FactoryBot.build(:place, latitude: "")).to be_invalid
  end
  it 'requires a longitude' do
    expect(FactoryBot.build(:place, longitude: "")).to be_invalid
  end
  
  it 'requires a Google Maps ID' do
    expect(FactoryBot.build(:place, google_maps_id: "")).to be_invalid
  end
  
  it 'does not require anything else' do
    expect(FactoryBot.build(:place, address: "")).to be_valid
    expect(FactoryBot.build(:place, hood: "")).to be_valid
    expect(FactoryBot.build(:place, city: "")).to be_valid
    expect(FactoryBot.build(:place, postcode: "")).to be_valid
    expect(FactoryBot.build(:place, phone: "")).to be_valid
    expect(FactoryBot.build(:place, website: "")).to be_valid
  end
  
  #= Behaviors ==================================================================#
  
  let(:response) { {status: 500} }
  let!(:stub) { stub_request(:get, /maps.googleapis.com/).to_return(response) }
  
  describe 'external API requests (Google Maps API)' do
    let(:new_values) { FactoryBot.build :place }
    let(:valid_hash) { FactoryBot.create(:place_details_hash, place: new_values) }
    
    context 'on creation' do
      subject { place.save! }
      
      it 'calls the API' do
        subject
        expect(stub).to have_been_requested
      end
      
      context 'when response is valid' do
        let(:response) { {status: 200, body: valid_hash.to_json} }
        
        it 'sets #address' do
          expect{ subject }.to change{ place.address }.to(new_values.address)
        end
        it 'sets #hood' do
          expect{ subject }.to change{ place.hood }.to(new_values.hood)
        end
        it 'sets #city' do
          expect{ subject }.to change{ place.city }.to(new_values.city)
        end
        it 'sets #province' do
          place.province = "ON"
          expect{ subject }.to change{ place.province }.to(new_values.province)
        end
        it 'sets #postcode' do
          expect{ subject }.to change{ place.postcode }.to(new_values.postcode)
        end
        
        it 'sets #phone' do
          expect{ subject }.to change{ place.phone }.to(new_values.phone)
        end
        it 'sets #website' do
          expect{ subject }.to change{ place.website }.to(new_values.website)
        end
        
        it 'does not change #latitude' do
          expect{ subject }.not_to change{ place.latitude }
        end
        it 'does not change #longitude' do
          expect{ subject }.not_to change{ place.longitude }
        end
      end
      context 'when response is invalid' do
        let(:response) { {status: 423, body: "Whatever".to_json} }
        
        it 'does not change #address' do
          expect{ subject }.not_to change{ place.address }
        end
        it 'does not change #hood' do
          expect{ subject }.not_to change{ place.hood }
        end
        it 'does not change #city' do
          expect{ subject }.not_to change{ place.city }
        end
        it 'does not change #province' do
          expect{ subject }.not_to change{ place.province }
        end
        it 'does not change #postcode' do
          expect{ subject }.not_to change{ place.postcode }
        end
        
        it 'does not change #phone' do
          expect{ subject }.not_to change{ place.phone }
        end
        it 'does not change #website' do
          expect{ subject }.not_to change{ place.website }
        end
        
        it 'does not change #latitude' do
          expect{ subject }.not_to change{ place.latitude }
        end
        it 'does not change #longitude' do
          expect{ subject }.not_to change{ place.longitude }
        end
      end
    end
    
    context 'on modification' do
      let(:response) { {status: 200, body: valid_hash.to_json} }
      
      before do
        @existing_place = FactoryBot.create(:place)
        WebMock.reset!
      end
      let(:place) { Place.find_by!(name: @existing_place.name) }
      
      subject { place.update(name: "Changed") }
      
      it 'does not call the API' do
        subject
        expect(stub).not_to have_been_requested
      end
      
      it 'does change the Place' do
        expect{ subject }.to change{ place.name }.to "Changed"
        expect(stub).not_to have_been_requested
      end
    end
  end
  
  #= Attributes =================================================================#
  
  let(:place) { FactoryBot.build(:place) }
  
  describe '#name' do
    subject { place.name }
    it { is_expected.to be_a(String) }
  end
  
  describe '#address' do
    subject { place.address }
    it { is_expected.to be_a(String) }
    
    it { is_expected.to start_with(place.number) }
    it { is_expected.to end_with(place.street) }
  end
  describe '#number' do
    subject { place.number }
    it { is_expected.to be_a(String) }
  end
  describe '#street' do
    subject { place.street }
    it { is_expected.to be_a(String) }
  end
  describe '#hood' do
    subject { place.hood }
    it { is_expected.to be_a(String) }
  end
  describe '#city' do
    subject { place.city }
    it { is_expected.to be_a(String) }
  end
  describe '#province' do
    subject { place.province }
    it { is_expected.to be_a(String) }
  end
  describe '#country' do
    subject { place.country }
    it { is_expected.to be_a(String) }
  end
  describe '#postcode' do
    subject { place.postcode }
    it { is_expected.to be_a(String) }
  end
  describe '#fsa' do
    subject { place.fsa }
    it { is_expected.to be_a(String) }
    it { is_expected.to eq place.postcode.split[0] }
  end
  
  describe '#latitude' do
    subject { place.latitude }
    it { is_expected.to be_a(Float) }
  end
  describe '#longitude' do
    subject { place.longitude }
    it { is_expected.to be_a(Float) }
  end
  
  describe '#google_maps_id' do
    subject { place.google_maps_id }
    it { is_expected.to be_a(String) }
  end
  
  describe '#phone' do
    subject { place.phone }
    it { is_expected.to be_a(String) }
  end
  describe '#website' do
    subject { place.website }
    it { is_expected.to be_a(String) }
  end
end
