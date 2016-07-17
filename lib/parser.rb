require './lib/file_as_array'

class Parser
  def initialize(file_path, data=Hash.new(0))
    @file = FileAsArray.new(file_path)
    @data = data
  end

  def most_viewed_pages
    remove_ips_from(@file.file_data)
    sorted_hash = @data.sort_by { |_key, value| value }.reverse.to_h
    sorted_hash.map { |k, v| "#{k} #{v} visits" }.join("\n")
  end

  private

  def remove_ips_from(arr)
    arr.map { |x| x.split(' ') }.each(&:pop).flatten.each { |v| @data[v] += 1 }
  end
end

most_viewed_list =
  "list of webpages with most page views ordered from most page views;\n"

ARGV.each do|a|
  puts "#{most_viewed_list + Parser.new(a).most_viewed_pages}"
end
