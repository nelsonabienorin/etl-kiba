class MyCsvDestination

  def initialize(output_file)
    @output_file = output_file
  end

  def write(row)
    @csv ||= CSV.open(@output_file, 'w')
    unless @headers_written
      @headers_written = true
      @csv << row.keys
    end
    @csv << row.values
  end

  def close
    @csv.close
  end

end