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
    it { is_expected.to validate_presence_of :username }
  end
end
