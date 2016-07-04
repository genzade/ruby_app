class Parser
  attr_reader :file_path, :most_viewed

  def initialize(file_path)
    @file_path = file_path
    @most_viewed = most_viewed_pages
  end

  def most_viewed_pages
    file = File.read(file_path).split(/\n+/)
    pages_views = file.map {|x| x.split(" ") }.each{ |x| x.pop }.flatten
    popular_pages = Hash.new(0)
    pages_views.each { |v| popular_pages[v] += 1 }
    popular_pages.sort_by {|_key, value| value}.reverse.to_h
  end

  def display_most_viewed
    @most_viewed.map{|k,v| "#{k} #{v} visits"}.join("\n")
  end
end