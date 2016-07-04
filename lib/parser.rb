class Parser
  attr_reader :file_path, :popular_pages

  def initialize(file_path)
    @file_path = file_path
    @popular_pages = Hash.new(0)
  end

  def most_viewed_pages
    file = File.read(file_path).split(/\n+/)
    pages_views = file.map {|x| x.split(" ") }.each{ |x| x.pop }.flatten
    pages_views.each { |v| @popular_pages[v] += 1 }
    @popular_pages.sort_by {|_key, value| value}.reverse.to_h
  end
end