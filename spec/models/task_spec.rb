RSpec.describe Task, type: :model do
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

  describe 'validations' do
    subject(:task) { create(:task) }

    it { is_expected.to validate_presence_of(:name) }

    context 'when valid name presents' do
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

      it 'raises an error' do
        expect { task.save! }.to raise_error(ActiveRecord::RecordInvalid)
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

      it 'raises an error' do
        expect { task.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when wrong deadline format' do
      subject(:task) { build(:task, deadline: 12) }

      it 'is invalid task' do
        expect(task).not_to be_valid
      end

      it 'does not save task into database' do
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { task.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when right deadline format' do
      subject(:task) { build(:task, deadline: 1.day.from_now) }

      it 'is valid task' do
        expect(task).to be_valid
      end

      it 'saves task into database' do
        task.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when deadline is nil' do
      subject(:task) { build(:task) }

      it 'is valid task' do
        expect(task).to be_valid
      end

      it 'saves task into database' do
        task.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when deadline is in the past' do
      subject(:task) { build(:task, deadline: '2019-07-13') }

      it 'is valid task' do
        expect(task).not_to be_valid
      end

      it 'saves task into database' do
        task.save
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { task.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
