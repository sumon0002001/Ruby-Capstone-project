require 'colorize'
require 'strscan'
require_relative 'file_reader.rb'

class ErrorChecker
  attr_reader :checker, :errors, :str

  def initialize(file_path)
    @file_path = file_path
    @checker = Buffer.new(file_path)
    @errors = []
    @str = %w[begin case class def do if module unless]
  end

  def checking_white_spaces
    @checker.content.each_with_index do |value, i|
      if value[-2] == ' ' && !value.strip.empty?
        @errors << "line:#{i + 1}:#{value.size - 1}: Error: whitespace detected."
        + " '#{value.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square Bracket')
  end

  def end_error
    pos_start = 0
    pos_end = 0
    @checker.content.each_with_index do |value, i|
      pos_start += 1 if @str.include?(value.split(' ').first) || value.split(' ').include?('do')
      pos_end += 1 if value.strip == 'end'
    end

    new_pos = pos_start <=> pos_end
    log_error("Lint/Syntax: Missing 'end'") if new_pos.eql?(1)
    log_error("Lint/Syntax: Unexpected 'end'") if new_pos.eql?(-1)
  end

  def check_empty_line_error
     @checker.content.each_with_index do |value, i|
      check_empty_line(value, i)
      check_def_empty_line(value, i)
      check_end_empty_line(value, i)
      check_do_empty_line(value, i)
    end
  end

   # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  def check_indentation_error
    error_msg = 'IndentationWidth: Use 2 spaces for indentation.'
    cur_val = 0
    indent_val = 0

    @checker.content.each_with_index do |value, i|
      new_line = value.strip.split(' ')
      exp_val = cur_val * 2
      res_word = %w[class def if elsif until module unless begin case]

      next unless !value.strip.empty? || !value.eql?('#')

      indent_val += 1 if res_word.include?(new_line.first) || new_line.include?('do')
      indent_val -= 1 if value.strip == 'end'

      next if value.strip.empty?

      indent_error(value, i, exp_val, error_msg)
      cur_val = indent_val
    end
  end

  private

  def indent_error(value, indx, exp_val, msg)
    strip_line = value.strip.split(' ')
    emp = value.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)

    if value.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      log_error("line:#{indx + 1} #{msg}") unless end_chk
    elsif !emp[0].size.eql?(exp_val)
      log_error("line:#{indx + 1} #{msg}")
    end
  end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
   
  def check_tag_error(*args)
    @checker.content.each_with_index do |value, i|
      tag_begin = []
      tag_end = []
      tag_begin << value.scan(args[0])
      tag_end << value.scan(args[1])
      new_arr = tag_begin.flatten.size <=> tag_end.flatten.size

      log_error("line:#{i + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if new_arr.eql?(1)
      log_error("line:#{i + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if new_arr.eql?(-1)
    end
  end

  def check_empty_line(value, i)
    msg = 'Extra empty line detected at class body beginning'

    return unless value.strip.split(' ').first.eql?('class')
  
    log_error("line:#{i + 2} #{msg}") if @checker.content[i + 1].strip.empty?
  end

  def check_def_empty_line(str_val, indx)
    msg1 = 'Extra empty line detected at method body beginning'
    msg2 = 'Use empty lines between method definition'

    return unless str_val.strip.split(' ').first.eql?('def')

    log_error("line:#{indx + 2} #{msg1}") if @checker.content[indx + 1].strip.empty?
    log_error("line:#{indx + 1} #{msg2}") if @checker.content[indx - 1].strip.split(' ').first.eql?('end')
  end

  def check_end_empty_line(str_val, indx)
    return unless str_val.strip.split(' ').first.eql?('end')

    log_error("line:#{indx} Extra empty line detected at class body end") if @checker.content[indx - 1].strip.empty?
    end

  def check_do_empty_line(str_val, indx)
    msg = 'Extra empty line detected at block body beginning'
    return unless str_val.strip.split(' ').include?('do')

    log_error("line:#{indx + 2} #{msg}") if @checker.content[indx + 1].strip.empty?
  end

  def log_error(error_msg)
    @errors << error_msg
  end
end
