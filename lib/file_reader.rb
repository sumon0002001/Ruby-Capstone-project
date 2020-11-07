require 'colorize'
class Buffer
  attr_reader :file_path, :error_msg, :contents
  attr_writer :contents_count
  def initialize(file_path)
    @file_path = file_path
    @error_msg = ''
   
    begin
      @contents = File.readlines(@file_path)
      @contents_count = @contents.size
    rescue StandardError => e
      @contents = []
      @error_msg = "Check file name or path again\n".colorize(:light_red) + e.to_s.colorize(:red)
    end
  end
end
