require_relative 'file_as_array'

class Parser
  def initialize(file_path)
    @file = FileAsArray.new(file_path)
    @data = Hash.new(0)
  end

  def most_viewed_pages
    remove_ips_from(@file.file_data)
    sorted_hash = @data.sort_by { |_key, value| value }.reverse.to_h
    sorted_hash.map { |k, v| "#{k} #{v} visits" }.join("\n")
  end

  def unique_pageviews
    pages = unique.values.flatten
    result = pages.each_with_object(Hash.new(0)) do |page, counts|
      counts[page] += 1
    end
    result.map { |k, v| "#{k} #{v} unique views" }.join("\n")
  end

  private

  attr_reader :pageviews

  def remove_ips_from(arr)
    arr.map { |x| x.split(' ') }.each(&:pop).flatten.each { |v| @data[v] += 1 }
  end

  def unique
    @pageviews = @file.file_data.map { |line| line.split(' ') }
    @pageviews.group_by { |_page, ip| ip }.each do |_key, value|
      value.each(&:pop).flatten!.uniq!
    end
  end
end

most_viewed_list =
  "list of webpages with most page views ordered from most page views;\n\n"

unique_pages_list =
  "list of webpages with most unique page views also ordered;\n\n"

ARGV.each do|a|
  parser = Parser.new(a)
  puts "#{most_viewed_list + parser.most_viewed_pages}\n\n"
  puts "#{unique_pages_list + parser.unique_pageviews}"
end
