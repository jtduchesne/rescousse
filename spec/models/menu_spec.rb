require 'rails_helper'

RSpec.describe Menu, type: :model do
  before { stub_google_maps }
  let(:menu) { FactoryBot.build(:menu) }
  
  #= Associations ===============================================================#
  
  describe '#items' do
    let(:menu) { FactoryBot.create(:menu) }
    
    subject { menu.items }
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_an(Item) }
  end
end
