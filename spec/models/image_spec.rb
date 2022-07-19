RSpec.describe Image, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:comment) }
  end

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:image_data).of_type(:text) }
    it { is_expected.to have_db_column(:comment_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
