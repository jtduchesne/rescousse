require 'rails_helper'

RSpec.describe Item, type: :model do
  #= Validations ================================================================#
  
  it 'requires a name' do
    expect(FactoryBot.build(:item, name: "")).to be_invalid
  end
  it 'does not require a unique name' do
    existing = FactoryBot.create(:item)
    expect(FactoryBot.build(:item, name: existing.name)).to be_valid
  end
  
  it 'requires an image' do
    expect(FactoryBot.build(:item, image: "")).to be_invalid
  end
  
  #= Attributes =================================================================#
  
  let(:item) { FactoryBot.build(:item) }
  
  describe '#name' do
    subject { item.name }
    it { is_expected.to be_a(String) }
  end
  describe '#description' do
    subject { item.description }
    it { is_expected.to be_a(String) }
  end
  describe '#size' do
    subject { item.size }
    it { is_expected.to be_a(String) }
  end
  describe '#image' do
    subject { item.image }
    it { is_expected.to be_a(String) }
  end
  
  describe '#price' do
    subject { item.price }
    it { is_expected.to be_a(Float) }
  end
end
