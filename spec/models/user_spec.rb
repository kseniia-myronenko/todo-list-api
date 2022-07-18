RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:username).of_type(:string) }
    it { is_expected.to have_db_column(:hashed_password).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:hashed_password) }

    it do
      expect(user).to validate_length_of(:username)
        .is_at_least(User::USERNAME_MIN_LENGTH).is_at_most(User::USERNAME_MAX_LENGTH)
    end

    it do
      expect(user).to validate_length_of(:hashed_password)
        .is_at_least(User::PASSWORD_MIN_LENGTH)
    end

    context 'when valid username presents' do
      it 'is validate user' do
        expect(user).to be_valid
      end

      it 'when successfully saved user' do
        user.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when username is empty' do
      subject(:user) { build(:user, :with_empty_username) }

      it 'is invalid user' do
        expect(user).not_to be_valid
      end

      it 'does not save user into database' do
        user.save
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when password is empty' do
      subject(:user) { build(:user, :with_empty_password) }

      it 'is invalid user' do
        expect(user).not_to be_valid
      end

      it 'does not save user into database' do
        user.save
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
