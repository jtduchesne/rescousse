require 'rails_helper'

RSpec.describe Authentication, type: :model do
  #= Validations ================================================================#
  
  it 'requires a provider' do
    expect(FactoryBot.build(:authentication, provider: nil)).not_to be_valid
  end
  it 'requires an uid' do
    expect(FactoryBot.build(:authentication, uid: nil)).not_to be_valid
  end
  
  it 'requires a valid user' do
    invalid_user = FactoryBot.build(:user, email: "")
    expect(FactoryBot.build(:authentication, user: invalid_user)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:authentication) { FactoryBot.build(:authentication) }
  
  describe '#provider' do
    subject { authentication.provider }
    it { is_expected.to be_a(String) }
  end
  
  describe '#uid' do
    subject { authentication.uid }
    it { is_expected.to be_a(String) }
  end
  
  #= Associations ===============================================================#
  
  describe '#user' do
    subject { authentication.user }
    it { is_expected.to be_a(User) }
  end
end
