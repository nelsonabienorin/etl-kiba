require 'rubygems'
require 'write_xlsx'

# require 'csv'

mytext = IO.read('NWBOR_show_file_values.xlsx')
puts

workbook = WriteXLSX.new('ruby.xlsx')
worksheet = workbook.add_worksheet
format = workbook.add_format
format.set_bold
format.set_color('red')
format.set_align('center')

col = row = 0
worksheet.write(row, col, 'Hi Excel', format)
worksheet.write(1, col, 'Hi Excel')

worksheet.write('A3', 1.2345)
worksheet.write('A4', '=SIN(PI()/4)')

workbook.close
