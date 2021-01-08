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
  
  #= Behaviors ==================================================================#
  
  context 'when it belongs to a default menu' do
    let(:item) { FactoryBot.create(:item, :default) }
    
    it 'is readonly' do
      expect(item).to be_readonly
    end
    it 'cannot be updated' do
      expect{ item.update(name: "Changed") }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
    it 'cannot be destroyed' do
      expect{ item.destroy }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
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
  
  describe '#default?' do
    let!(:past)    { FactoryBot.create(:default_menu, :past) }
    let!(:current) { FactoryBot.create(:default_menu) }
    
    let(:item) { FactoryBot.create(:item) }
    
    subject { item.default? }
    it { is_expected.to be(false) }
    
    context 'when it belongs to a previous default menu' do
      before { past.items << item }
      it { is_expected.to be(false) }
    end
    context 'when it belongs to the current default menu' do
      before { current.items << item }
      it { is_expected.to be(true) }
    end
  end
end
