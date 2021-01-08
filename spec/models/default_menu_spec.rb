require 'rails_helper'

RSpec.describe DefaultMenu, type: :model do
  let(:default_menu) { FactoryBot.build(:default_menu) }
  
  #= Associations ===============================================================#
  
  describe '#items' do
    let(:default_menu) { FactoryBot.create(:default_menu) }
    
    subject { default_menu.items }
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_an(Item) }
    
    it { expect(subject.take).to be_readonly }
  end
  
  #= Class methods ==============================================================#
  
  describe '.current' do
    let!(:past)    { FactoryBot.create(:default_menu, :past) }
    let!(:current) { FactoryBot.create(:default_menu) }
    
    subject { DefaultMenu.current }
    
    it { is_expected.to be_a(DefaultMenu) }
    it { is_expected.to eq current }
  end
end
