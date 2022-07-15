RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:images).dependent(:destroy) }
    it { is_expected.to belong_to(:task) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_column(:task_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :content }

    context 'when valid content presents' do
      subject(:comment) { build(:comment) }

      it 'is valid comment' do
        expect(comment).to be_valid
      end

      it 'when successfully saved comment' do
        comment.save
        expect(described_class.count).to eq(1)
      end
    end

    context 'when content is empty' do
      subject(:comment) { build(:comment, :empty_content) }

      it 'is invalid comment' do
        expect(comment).not_to be_valid
      end

      it 'does not save comment into database' do
        comment.save
        expect(described_class.count).to eq(0)
      end
    end

    context 'when without task' do
      subject(:comment) { build(:comment, :without_task) }

      it 'is invalid comment' do
        expect(comment).not_to be_valid
      end

      it 'does not save comment into database' do
        comment.save
        expect(described_class.count).to eq(0)
      end
    end
  end
end
