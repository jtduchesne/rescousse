require 'rails_helper'

RSpec.describe User, type: :model do
  #= Validations ================================================================#
  
  it 'requires a name' do
    expect(FactoryBot.build(:user, name: nil)).not_to be_valid
  end
  
  it 'requires an email' do
    expect(FactoryBot.build(:user, email: nil)).not_to be_valid
  end
  it 'requires a valid email' do
    expect(FactoryBot.build(:user, email: "<b>invalid</b>@email.com")).not_to be_valid
  end
  it 'requires a unique email' do
    existing = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: existing.email)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:user) { FactoryBot.build(:user) }
  
  describe '#name' do
    subject { user.name }
    it { is_expected.to be_a(String) }
  end
  
  describe '#email' do
    subject { user.email }
    it { is_expected.to be_a(String) }
  end
  
  #= Associations ===============================================================#
  
  describe '#authentication' do
    let(:user) { FactoryBot.create(:user, :authenticated) }
    
    subject { user.authentications }
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_an(Authentication) }
  end
end
