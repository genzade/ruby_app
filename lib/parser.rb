class Parser

  def initialize(file_path)
    @file_arr = date(file_path)
  end

  def most_viewed_pages
    pages_views = @file_arr.map { |x| x.split(' ') }.each(&:pop).flatten
    popular_pages = Hash.new(0)
    pages_views.each { |v| popular_pages[v] += 1 }
    popular_pages.sort_by { |_key, value| value }.reverse.to_h
  end
end
