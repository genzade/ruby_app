class Parser
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    # @data = most_viewed_pages
  end

  def most_viewed_pages
    file = date(@file_path)
    pages_views = file.map { |x| x.split(' ') }.each(&:pop).flatten # deletes IP addresses, splits file data into array
    # p pages_views
    popular_pages = Hash.new(0)
    pages_views.each { |v| popular_pages[v] += 1 } # hash key[pages]: :value[number of views]
    p popular_pages

    popular_pages.sort_by { |_key, value| value }.reverse.to_h

  end

  # def display_most_viewed
  #   @data.map{ |k, v| "#{k} #{v} visits" }.join("\n")
  # end

  private

  def date(file_path)
    File.read(file_path).split(/\n+/)
  end
end
