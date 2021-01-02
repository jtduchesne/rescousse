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
  
  describe '#first_name' do
    subject { user.first_name }
    it { is_expected.to be_a(String) }
    
    it 'returns the first part of #name' do
      expect(user.name).to start_with subject
    end
    it 'works with compound names' do
      user.name = "Jean-Test Lastname"
      expect(subject).to eq "Jean-Test"
    end
  end
  
  describe '#name' do
    subject { user.name }
    it { is_expected.to be_a(String) }
  end
  
  describe '#initials' do
    subject { user.initials }
    it { is_expected.to be_a(String) }
    
    it 'returns the first letters of every names' do
      user.name = "Test Name"
      expect(subject).to eq "TN"
    end
    it 'returns only capital letters' do
      user.name = "test name"
      expect(subject).to eq "TN"
    end
    it 'works with compound names' do
      user.name = "Jean-Test Lastname"
      expect(subject).to eq "JTL"
    end
    it 'returns a maximum of 3 letters' do
      user.name = "Jean-Test Last Name"
      expect(subject).to eq "JTL"
    end
    it 'skips 2 letters or less middle names' do
      user.name = "Homer J. Simpson"
      expect(subject).to eq "HS"
    end
  end
  
  describe '#email' do
    subject { user.email }
    it { is_expected.to be_a(String) }
  end
  
  describe '#admin?' do
    subject { user.admin? }
    it { is_expected.to be false }
    
    context "if user's role is administrator" do
      let(:user) { FactoryBot.create(:user, :administrator) }
      
      it { is_expected.to be true }
    end
  end
  
  #= Associations ===============================================================#
  
  describe '#authentication' do
    let(:user) { FactoryBot.create(:user, :authenticated) }
    
    subject { user.authentications }
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_an(Authentication) }
  end
  
  describe '#role' do
    let(:user) { FactoryBot.create(:user, :administrator) }
    
    subject { user.role }
    it { expect(subject).to be_a(Role) }
  end
  
  describe '#favorites' do
    before { stub_google_maps }
    let(:user) { FactoryBot.create(:user, favorites: [FactoryBot.create(:place)]) }
    
    subject { user.favorites }
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_a(Place) }
  end
  
  #= Instance Methods ===========================================================#
  
  describe '#make_admin!' do
    let(:user) { FactoryBot.create(:user) }
    
    subject { user.send :make_admin! }
    
    it "promotes user to administrator" do
      expect{ subject }.to change{ user.admin? }.from(false).to(true)
    end
    
    it 'cannot be called directly' do
      expect{ user.make_admin! }.to raise_error(NoMethodError)
    end
    it 'cannot be used on more than 1 user' do
      FactoryBot.create(:user, :administrator)
      expect{ subject }.to raise_error(ActiveRecord::ActiveRecordError)
    end
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
