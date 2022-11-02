RSpec.describe UsersForms::CreateForm, type: :model do
  describe 'validations' do
    subject(:user) { described_class.new(User.new) }

    it { is_expected.not_to allow_value(nil).for(:password) }

    it do
      expect(user).to validate_length_of(:password)
        .is_at_least(UsersForms::CreateForm::PASSWORD_MIN_LENGTH)
    end

    context 'with valid values' do
      context 'with valid password' do
        let(:user) { described_class.new(create(:user)) }
        let(:passwords) { ['Password_123', 'Password+1'] }

        it { expect(user).to allow_values(*passwords).for(:password) }
      end
    end

    context 'with invalid values' do
      context 'with invalid password' do
        let(:user) { described_class.new(create(:user)) }
        let(:passwords) { %w[P passwor] }

        it do
          expect(user).not_to allow_values(passwords).for(:password)
        end
      end
    end
  end
end
