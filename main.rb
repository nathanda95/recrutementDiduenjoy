require 'rubyXL'
require 'pg'

require_relative 'affichage'
require_relative 'class/item'
require_relative 'class/order'
require_relative 'parsing'

def main()
    workbook = RubyXL::Parser.parse("Orders2.xlsx")
    orders = []
    parse_file(orders, workbook)
    print_orders(orders)
end

main()




