RSpec.describe UsersForms::BaseForm, type: :model do
  describe 'validations' do
    subject(:user) { described_class.new(User.new) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.not_to allow_value(nil).for(:username) }

    it do
      expect(user).to validate_length_of(:username)
        .is_at_least(UsersForms::BaseForm::USERNAME_MIN_LENGTH).is_at_most(UsersForms::BaseForm::USERNAME_MAX_LENGTH)
    end

    context 'with valid username' do
      let(:valid_usernames) { %w[TestLastUserName Username user.over_test] }

      it 'allows correct usernames' do
        expect(user).to allow_values(*valid_usernames)
          .for(:username)
      end
    end

    context 'with invalid username' do
      let(:invalid_usernames) { ['n' * (UsersForms::BaseForm::USERNAME_MAX_LENGTH + 1), 'Vi'] }

      it "doesn't allow invalid usernames" do
        expect(user).not_to allow_values(*invalid_usernames)
          .for(:username)
      end
    end
  end
end
