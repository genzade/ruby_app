class FileAsArray
  def initialize(file_path)
    fail 'invalid file, must be .log' if File.extname(file_path) != '.log'
    @file_path = file_path
  end

  def file_data
    File.read(@file_path).split(/\n+/)
  end
end
