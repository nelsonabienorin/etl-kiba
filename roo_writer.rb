require 'kiba'
require 'csv'
require 'write_xlsx'
require 'roo'

class MyCsvSource
  attr_reader :input_file
  def initialize(input_file)
    @input_file = input_file
    # each
  end

  def each
    puts 'fer'
    workbook = WriteXLSX.new('ruby_output.xlsx')
    worksheet = workbook.add_worksheet
    format = workbook.add_format
    format.set_bold
    format.set_color('red')
    format.set_align('center')

    columns = []
    (2..4).each do |r|
      columns << Roo::Excel.new("./nwbor_csv/residential_search_layout_table.csv").column(r)
    end
    puts columns

    # CSV.open(input_file, headers: true, header_converters: :symbol) do |csv|
    #   puts 'Nel'
    #   # csv.each do |row|
    #   #   puts 'Adex'
    #   #   yield(row.to_hash['Property Status'])
    #   # end
    # end

    workbook.close
  end
end
#
# fileName = './nwbor_csv/residential_search_layout_table.csv'
# sheet_content = IO.read(fileName)
# sheetArray = sheet_content.split(',')
#
# workbook = WriteXLSX.new('r.xlsx')
# worksheet = workbook.add_worksheet
# format = workbook.add_format
# format.set_bold
# format.set_color('red')
# format.set_align('center')
#
#
#
# rowCount = 0
#
# sheetArray.each do |item|
#   worksheet.write("A#{rowCount+1}", item)
# end
#
# col = row = 0
# worksheet.write("A5:A23", 1.2345)
# worksheet.write(row, col, 'Hi Excel', format)

#
# workbook.close

#
# col = row = 0
# worksheet.write(row, col, 'Hi Excel', format)
# worksheet.write(1, col, 'Hi Excel')
#
# worksheet.write('A3', 1.2345)
# worksheet.write('A4', '=SIN(PI()/4)')

# job_definition = Kiba.parse(sheet_content, fileName)
# Kiba.run(job_definition)
# csvsrc = MyCsvSource.new(sheet_content)
