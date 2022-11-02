RSpec.describe Project do
  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    subject(:project) { create(:project) }

    it { is_expected.to validate_presence_of(:name) }

    context 'when valid name presents' do
      it 'is validate project' do
        expect(project).to be_valid
      end

      it 'when successfully saved project' do
        project.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when name is empty' do
      subject(:project) { build(:project, :empty_name) }

      it 'is invalid project' do
        expect(project).not_to be_valid
      end

      it 'does not save project into database' do
        project.save
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { project.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when without user' do
      subject(:project) { build(:project, :without_user) }

      it 'is invalid project' do
        expect(project).not_to be_valid
      end

      it 'does not save project into database' do
        project.save
        expect(described_class.count).to eq(0)
      end

      it 'raises an error' do
        expect { project.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when duplicate project name' do
      before { project.save }

      let(:project_with_duplicated_name) { build(:project, name: project.name, user: project.user) }

      it 'is invalid project' do
        expect(project_with_duplicated_name).not_to be_valid
      end

      it 'does not save second project into database' do
        project_with_duplicated_name.save
        expect(described_class.count).to eq(1)
      end

      it 'raises an error' do
        expect { project_with_duplicated_name.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#completed_project?' do
    subject(:project) { build(:project) }

    context 'when there are undone tasks' do
      before do
        create_list(:task, 5, :done, project:)
        create_list(:task, 5, :undone, project:)
      end

      it 'is expected to be not completed project' do
        expect(project.completed_project?).to be(false)
      end
    end

    context 'when all tasks are completed' do
      before { create_list(:task, 5, :done, project:) }

      it 'is expected to be completed project' do
        expect(project.completed_project?).to be(true)
      end
    end
  end
end
