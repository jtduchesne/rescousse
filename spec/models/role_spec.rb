require 'rails_helper'

RSpec.describe Role, type: :model do
  #= Validations ================================================================#
  
  it 'requires a name' do
    expect(FactoryBot.build(:role, name: nil)).not_to be_valid
  end
  it 'requires a unique name' do
    existing = FactoryBot.create(:role)
    expect(FactoryBot.build(:role, name: existing.name)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:role) { FactoryBot.build(:role) }
  
  describe '#name' do
    subject { role.name }
    it { is_expected.to be_a(String) }
  end
  
  describe '#administrator?' do
    subject { role.administrator? }
    it { is_expected.to be(true).or be(false) }
  end
  
  #= Associations ===============================================================#
  
  describe '#user' do
    subject { role.user }
    it { expect(subject).to be_a(User) }
  end
end
