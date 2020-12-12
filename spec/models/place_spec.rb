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
  
  it 'does not require anything else' do
    expect(FactoryBot.build(:place, address: "")).to be_valid
    expect(FactoryBot.build(:place, hood: "")).to be_valid
    expect(FactoryBot.build(:place, city: "")).to be_valid
    expect(FactoryBot.build(:place, postcode: "")).to be_valid
    expect(FactoryBot.build(:place, latitude: "")).to be_valid
    expect(FactoryBot.build(:place, longitude: "")).to be_valid
    expect(FactoryBot.build(:place, phone: "")).to be_valid
    expect(FactoryBot.build(:place, email: "")).to be_valid
    expect(FactoryBot.build(:place, website: "")).to be_valid
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
  describe '#postcode' do
    subject { place.postcode }
    it { is_expected.to be_a(String) }
  end
  
  describe '#latitude' do
    subject { place.latitude }
    it { is_expected.to be_a(Float) }
  end
  describe '#longitude' do
    subject { place.longitude }
    it { is_expected.to be_a(Float) }
  end
  
  describe '#phone' do
    subject { place.phone }
    it { is_expected.to be_a(String) }
  end
  describe '#email' do
    subject { place.email }
    it { is_expected.to be_a(String) }
  end
  describe '#website' do
    subject { place.website }
    it { is_expected.to be_a(String) }
  end
end
