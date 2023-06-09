require_relative '../book'

RSpec.describe Book do
  let(:id) { 1 }
  let(:genre) { 'Fiction' }
  let(:author) { 'John Doe' }
  let(:source) { 'Library' }
  let(:label) { 'Bestseller' }
  let(:publish_date) { Date.parse('2023-01-01') }
  let(:publisher) { 'Example Publisher' }
  let(:cover_state) { 'good' }

  subject(:book) { described_class.new(id, genre, author, source, label, publish_date, publisher, cover_state) }

  describe '#can_be_archived?' do
    context 'when the cover state is good and it can be archived' do
      before do
        allow(book).to receive(:archived).and_return(true)
      end
    end

    context 'when the cover state is bad and it can be archived' do
      before do
        allow(book).to receive(:cover_state).and_return('bad')
        allow(book).to receive(:archived).and_return(true)
      end
    end

    context 'when the cover state is good and it cannot be archived' do
      before do
        allow(book).to receive(:archived).and_return(false)
      end

      it 'returns false' do
        expect(book.can_be_archived?).to eq(false)
      end
    end

    context 'when the cover state is bad and it cannot be archived' do
      before do
        allow(book).to receive(:cover_state).and_return('bad')
        allow(book).to receive(:archived).and_return(false)
      end

      it 'returns false' do
        expect(book.can_be_archived?).to eq(false)
      end
    end
  end
end
