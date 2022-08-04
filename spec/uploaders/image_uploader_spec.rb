require 'sidekiq/testing'

Sidekiq::Testing.inline!

RSpec.describe ImageUploader, type: :uploader do
  describe 'valid files validation check' do
    context 'when checks jpg format' do
      subject(:image_file) { create(:image, image: file_fixture('acceptable_size_image-1.jpg').open) }

      it 'extracts mime_type' do
        expect(image_file.image.mime_type).to eq('image/jpeg')
      end

      it 'extracts size' do
        expect(image_file.image.size).to be <= Image::MAX_SIZE
      end
    end

    context 'when checks png format' do
      subject(:image_file) { create(:image, image: file_fixture('acceptable_size_image-2.png').open) }

      it 'extracts mime_type' do
        expect(image_file.image.mime_type).to eq('image/png')
      end

      it 'extracts size' do
        expect(image_file.image.size).to be <= Image::MAX_SIZE
      end
    end

    context 'when checks thumb size' do
      subject(:image_file) { create(:image, image: file_fixture('acceptable_size_image-2.png').open) }

      let(:value) { JSON.parse(image_file.image_data) }

      before do
        image_file.image_derivatives!
        image_file.save
      end

      it 'have expected width' do
        expect(value['derivatives']['thumb']['metadata']['width']).to match(Image::THUMBNAIL_SIZE[:thumb][0])
      end

      it 'have expected height' do
        expect(value['derivatives']['thumb']['metadata']['height']).to match(Image::THUMBNAIL_SIZE[:thumb][1])
      end
    end

    context 'when remove image' do
      subject!(:image_file) { create(:image, image: file_fixture('acceptable_size_image-2.png').open) }

      before do
        image_file.destroy
      end

      it 'expects image not to be existed' do
        expect(Image.count).to be(0)
      end
    end
  end

  describe 'invalid files validation check' do
    context 'when size is too large' do
      subject(:image_file) { build(:image, image: file_fixture('big_size_image.jpg').open) }

      it 'is too big file' do
        expect(image_file).not_to be_valid
      end

      it 'raises an error' do
        image_file.valid?
        expect(image_file.errors[:image]).to include(I18n.t('activerecord.errors.models.image.too_large',
                                                            max_size: Image::MAX_SIZE))
      end
    end

    context 'when wrong mime-type' do
      let(:doc_file) { build(:image, image: file_fixture('not_image.doc').open) }
      let(:pdf_file) { build(:image, image: file_fixture('not_image.pdf').open) }

      it 'raises an error when uploading doc file' do
        expect { doc_file.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'doc is wrong type' do
        expect(doc_file).not_to be_valid
      end

      it 'raises an error when uploading pdf file' do
        expect { pdf_file.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'pdf is wrong type' do
        expect(pdf_file).not_to be_valid
      end
    end
  end
end
