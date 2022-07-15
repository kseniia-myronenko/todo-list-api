RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:project_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:deadline).of_type(:datetime) }
    it { is_expected.to have_db_column(:priority).of_type(:integer) }
    it { is_expected.to have_db_column(:done).of_type(:boolean) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }

    context 'when valid name presents' do
      subject(:task) { build(:task) }

      it 'is validate task' do
        expect(task).to be_valid
      end

      it 'when successfully saved task' do
        task.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when name is empty' do
      subject(:task) { build(:task, :empty_name) }

      it 'is invalid task' do
        expect(task).not_to be_valid
      end

      it 'does not save task into database' do
        task.save
        expect(described_class.count).to eq(0)
      end
    end

    context 'when without project' do
      subject(:task) { build(:task, :without_project) }

      it 'is invalid task' do
        expect(task).not_to be_valid
      end

      it 'does not save task into database' do
        task.save
        expect(described_class.count).to eq(0)
      end
    end
  end
end
