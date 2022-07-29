RSpec.describe TasksSortService, type: :service do
  describe 'params with position' do
    context 'when position is asc' do
      let!(:result) { described_class.call(params:) }
      let!(:params) { { position: 'asc' } }
      let!(:project) { create(:project, user: create(:user)) }
      let!(:tasks_list) do
        [
          create(:task, project:, position: 1),
          create(:task, project:, position: 2)
        ]
      end

      before do
        project.tasks.order(result)
      end

      it 'is expected first task to be on top of the list' do
        expect(project.tasks).to match(tasks_list)
      end
    end

    context 'when position is desc' do
      let!(:result) { described_class.call(params:) }
      let!(:params) { { position: 'desc' } }
      let!(:project) { create(:project, user: create(:user)) }
      let!(:tasks_list) do
        [
          create(:task, project:, position: 2),
          create(:task, project:, position: 1)
        ]
      end

      before do
        project.tasks.order(result)
      end

      it 'is expected first task to be on top of the list' do
        expect(project.tasks).to match(tasks_list)
      end
    end
  end

  describe 'params with created_at' do
    context 'when created_at is asc' do
      let!(:result) { described_class.call(params:) }
      let!(:params) { { created_at: 'asc' } }
      let!(:project) { create(:project, user: create(:user)) }
      let!(:tasks_list) do
        [
          create(:task, project:, created_at: '2022-05-19'),
          create(:task, project:, created_at: Time.zone.now)
        ]
      end

      before do
        project.tasks.order(result)
      end

      it 'is expected first task to be on top of the list' do
        expect(project.tasks).to match(tasks_list)
      end
    end

    context 'when created_at is desc' do
      let!(:result) { described_class.call(params:) }
      let!(:params) { { created_at: 'desc' } }
      let!(:project) { create(:project, user: create(:user)) }
      let!(:tasks_list) do
        [
          create(:task, project:, created_at: Time.zone.now),
          create(:task, project:, created_at: '2022-05-19')
        ]
      end

      before do
        project.tasks.order(result)
      end

      it 'is expected first task to be on top of the list' do
        expect(project.tasks).to match(tasks_list)
      end
    end
  end

  describe 'when position is nil' do
    let!(:result) { described_class.call(params:) }
    let!(:params) { nil }
    let!(:project) { create(:project, user: create(:user)) }
    let!(:tasks_list) do
      [
        create(:task, project:, position: 1),
        create(:task, project:, position: 2)
      ]
    end

    before do
      project.tasks.order(result)
    end

    it 'expect tasks been sorted in default way (created_at: :asc)' do
      expect(project.tasks).to match(tasks_list)
    end
  end
end
