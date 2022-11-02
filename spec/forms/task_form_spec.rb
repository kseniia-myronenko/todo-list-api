RSpec.describe TaskForm, type: :model do
  describe 'validations' do
    subject(:task) { described_class.new(project.tasks.new) }

    let(:project) { create(:project, user: create(:user)) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
    it { is_expected.not_to allow_value(nil).for(:project_id) }

    context 'with valid name' do
      let(:valid_names) { ['Make coffee', 'Make homework'] }

      it 'allows correct names' do
        expect(task).to allow_values(*valid_names)
          .for(:name)
      end
    end

    context 'with empty name' do
      let(:invalid_name) { '' }

      it "doesn't allow empty name" do
        expect(task).not_to allow_values(invalid_name)
          .for(:name)
      end
    end

    context 'when without project' do
      let(:blank_project) { '' }

      it "doesn't allow empty project_id" do
        expect(task).not_to allow_values(blank_project)
          .for(:project_id)
      end
    end

    context 'when wrong deadline format' do
      subject(:task) { described_class.new(project.tasks.new(deadline: 12)) }

      it 'is invalid task' do
        expect(task).not_to be_valid
      end
    end

    # context 'when right deadline format' do
    #   subject(:task) { described_class.new(project.tasks.new(deadline: 1.day.from_now)) }

    #   it 'is valid task' do
    #     expect(task.model).to be_valid
    #   end

    #   it 'saves task into database' do
    #     task.save
    #     expect(Task.count).to eq(1)
    #   end
    # end

    # context 'when deadline is nil' do
    #   subject(:task) { build(:task) }

    #   it 'is valid task' do
    #     expect(task).to be_valid
    #   end

    #   it 'saves task into database' do
    #     task.save
    #     expect(described_class.count).to eq(1)
    #   end
    # end

    # context 'when deadline is in the past' do
    #   subject(:task) { build(:task, deadline: '2019-07-13') }

    #   it 'is valid task' do
    #     expect(task).not_to be_valid
    #   end

    #   it 'saves task into database' do
    #     task.save
    #     expect(described_class.count).to eq(0)
    #   end

    #   it 'raises an error' do
    #     expect { task.save! }.to raise_error(ActiveRecord::RecordInvalid)
    #   end
    # end
  end
end
