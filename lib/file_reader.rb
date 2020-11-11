require 'colorize'

class Buffer
  attr_reader :error_msg, :content, :file_path, :content_size
  def initialize(file_path)
    @error_msg = ''
    @file_path = file_path =~ @empty || file_path.nil? ? 'no path' : file_path
    begin
      @content = File.readlines(@file_path)
      @content_size = @content.size
    rescue StandardError => e
      @content = []
      @error_msg = "sorry no file or path is found\n".colorize(:light_red) + e.to_s.colorize(:red)
    end
  end
end
