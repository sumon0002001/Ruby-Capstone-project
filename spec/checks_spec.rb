require_relative '../lib/checks.rb'

describe ErrorChecker do
  let(:checker) { ErrorChecker.new('bug.rb') }

  describe '#checking_white_spaces' do
    it 'should return trailing space error on line 3' do
      checker.checking_white_spaces
      expect(checker.errors[0]).to eql('line:3:18: Error: whitespace detected.')
    end
  end

  describe '#check_indentation_error' do
    it 'should return indentation space error on line 4' do
      checker.check_indentation_error
      expect(checker.errors[0]).to eql('line:4 IndentationWidth: Use 2 spaces for indentation.')
    end
  end

  describe '#tag_error' do
    it "returns missing/unexpected tags eg '( )', '{}', and '[]'" do
      checker.tag_error
      expect(checker.errors[0]).to eql("line:3 Lint/Syntax: Unexpected/Missing token ']' Square Bracket")
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]).to eql("Lint/Syntax: Missing 'end'")
    end
  end

  describe '#check_empty_line_error' do
    it 'returns empty line error' do
      checker.check_empty_line_error
      expect(checker.errors[0]).to eql('line:11 Extra empty line detected at class body end')
    end
  end
end
