require 'csv'
require 'awesome_print'

class CSVSource
  def initialize (filename:)
    @filename = filename
  end

  def each
    csv = CSV.open(@filename, headers: true)
    csv.each do |row|
      yield(row.to_hash)
    end
    csv.close
  end
end

def show_me!
  transform do |row|
    ap row
    row
  end
end

def limit(x)
  x = Integer(x || -1)
  return if x == -1
  transform do |row|
    @counter ||= 0
    @counter += 1
    abort("Stopping...") if @counter > x
    row
  end
end

class MovieDBLookup
  def initialize (api_key:, title_field:)
    @title_field = title_field
    Tmdb::Api.key(api_key)
  end

  def process(row)
    movie = Tmdb::Movie.find(row[@title_field]).first
    row[:vote_average] = movie.vote_average
    row[:vote_count] = movie.vote_count
    row
  end
end

