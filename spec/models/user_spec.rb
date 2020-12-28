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
  
  #= Class Methods ==============================================================#
  
  describe '.from_omniauth' do
    let(:auth_hash) { FactoryBot.create :omniauth_hash }
    
    subject { User.from_omniauth(auth_hash) }
    
    context 'when the user does not already exist' do
      it { is_expected.to be_a User }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      
      it 'creates a new Authentication' do
        expect{ subject }.to change{ Authentication.count }.by(1)
      end
      
      it 'creates a new User' do
        expect{ subject }.to change{ User.count }.by(1)
      end
      it 'sets its name' do
        expect(subject.name).to eq auth_hash['info']['name']
      end
      it 'sets its email' do
        expect(subject.email).to eq auth_hash['info']['email']
      end
    end
    context 'when the user already exists' do
      let!(:existing_user) { User.from_omniauth(auth_hash) }
      
      it { is_expected.to be_a User }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      
      it 'does not create a new Authentication' do
        expect{ subject }.not_to change{ Authentication.count }
      end
      
      it 'does not create a new User' do
        expect{ subject }.not_to change{ User.count }
      end
      
      it 'returns the existing user' do
        expect(subject).to eq existing_user
      end
      
      context 'and his name and email has been changed' do
        before { existing_user.update(name: "Changed Name",
                                      email: "changed@email.com") }
        
        it 'does not change his name back' do
          expect{ subject }.not_to change{ existing_user.reload.name }
          expect(subject.name).to eq "Changed Name"
        end
        it 'does not change his email back' do
          expect{ subject }.not_to change{ existing_user.reload.email }
          expect(subject.email).to eq "changed@email.com"
        end
      end
    end
    context 'when there is a problem creating the user' do
      let(:auth_hash) { FactoryBot.create :omniauth_hash, infos: {email: ""} }
      
      it { is_expected.to     be_a User }
      it { is_expected.not_to be_valid }
      it { is_expected.not_to be_persisted }
      
      it 'does not create a new Authentication' do
        expect{ subject }.not_to change{ Authentication.count }
      end
      
      it 'does not create a new User' do
        expect{ subject }.not_to change{ User.count }
      end
      it 'does set its name' do
        expect(subject.name).to eq auth_hash['info']['name']
      end
      it 'does set its email' do
        expect(subject.email).to eq auth_hash['info']['email']
      end
      
      context 'and the problem is fixed' do
        let(:fix) { subject.update(email: "fixed@email.com") }
        
        it 'creates a new Authentication' do
          expect{ fix }.to change{ Authentication.count }.by(1)
        end
        it 'creates a new User' do
          expect{ fix }.to change{ User.count }.by(1)
        end
      end
    end
  end
end
