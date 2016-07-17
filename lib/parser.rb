class Parser
  def initialize(file_path, data=Hash.new(0))
    @file = file_arr(file_path)
    @data = data
  end

  def most_viewed_pages
    remove_ips_from(@file)
    sorted_hash = @data.sort_by { |_key, value| value }.reverse.to_h
    sorted_hash.map { |k, v| "#{k} #{v} visits" }.join("\n")
  end

  def file_arr(file_path)
    if File.extname(file_path) == '.log'
      File.read(file_path).split(/\n+/)
    else
      fail 'invalid file, must be .log'
    end
  end

  private

  def remove_ips_from(arr)
    arr.map { |x| x.split(' ') }.each(&:pop).flatten.each { |v| @data[v] += 1 }
  end
end

# most_viewed_list =
#   "list of webpages with most page views ordered from most page views;\n"

# puts most_viewed_list + Parser.new(ARGV.first).most_viewed_pages
