class Parser

  def most_viewed_pages(file_path)
    file = File.read(file_path).split(/\n+/)
    pages = file.map {|x| x.split(" ") }.each{ |x| x.pop }.flatten
    popular_pages = Hash.new(0)

    pages.each { |v| popular_pages[v] += 1 }
    popular_pages.sort_by {|_key, value| value}.reverse.to_h
  end
end