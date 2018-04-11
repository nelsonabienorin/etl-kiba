require 'csv'
require 'roo'


class MyCsvSource
  attr_reader :input_file

  def initialize(input_file)
    @input_file = input_file
  end

  def formatPropertyTableColumn word
    camelizedArray = word.scan(/[A-Z][a-z]+/)

    if camelizedArray.count == 2
      result = "#{camelizedArray[0]}_#{camelizedArray[1]}"
    elsif camelizedArray.count == 3
      result = "#{camelizedArray[0]}_#{camelizedArray[1]}_#{camelizedArray[2]}"
    else
      result = word
    end

  end

  def formatHashColumn(tableName,code,label)
    "{table: :#{tableName}, code: '#{code}', label: '#{label}'}"
  end

  def each
    xlsx = Roo::Excelx.new(@input_file)
    columnA = xlsx.sheet('residential_search_layout').column(1)
    columnB = xlsx.sheet('residential_search_layout').column(2)
    columnC = xlsx.sheet('residential_search_layout').column(3)

    resultArray = []
    prefixArray = []

    columnA.each_with_index  do |row, index|
      unless columnA[index].nil?
        prefixArray.push(columnA[index])
      end

      unless columnB[index].nil?
         resultArray.push( "#{prefixArray.last} - #{columnB[index]}")
      end

      unless columnC[index].nil?
        getPropertyTableCol = formatPropertyTableColumn (columnC[index])
        getFormattedHash = formatHashColumn(
                            getPropertyTableCol,
                            columnC[index].downcase(),
                            columnB[index]
                          )

        yield({
                index: index+1,
                row: "#{prefixArray.last} - #{columnB[index]}",
                propertyTableColumn: "#{columnC[index]}",
                DatabaseTableName: getPropertyTableCol,
                formatHashColumn: getFormattedHash
              })
      end
    end

  end
end