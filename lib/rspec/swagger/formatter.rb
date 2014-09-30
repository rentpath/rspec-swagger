module Rspec
  module Swagger
    class Formatter
      def initialize(table_widths: [25, 40])
        @table_widths = table_widths.freeze
      end

      # format()
      #
      # Set passed to true for green output, false for red. You can color
      # any part of the left or right text by using <...> (which are invalid
      # URL characters anyway, so shouldn't ever appear in the output
      def format(passed: true, left_text: "", right_text: "")
        if passed
          str = "<.> "
        else
          str = "<F> "
        end

        str += sprintf("%#{@table_widths[0]}.#{@table_widths[0]}s | ", left_text)
        str += sprintf("%-#{@table_widths[1]}.#{@table_widths[1]}s", right_text)

        if passed
          str = str.gsub(/\<(.*?)\>/) { |match| $1.green }
          str = str.gsub(/\<(.*?)$/)  { |match| $1.green }
        else
          str = str.gsub(/\<(.*?)\>/) { |match| $1.red }
          str = str.gsub(/\<(.*?)$/)  { |match| $1.red }
        end

        puts str
      end
    end
  end
end
