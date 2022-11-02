RSpec.describe Task do
  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:project_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:deadline).of_type(:date) }
    it { is_expected.to have_db_column(:position).of_type(:integer) }
    it { is_expected.to have_db_column(:done).of_type(:boolean) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
