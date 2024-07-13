require 'rubyXL'
require 'pg'

require_relative 'affichage'
require_relative 'class/item'
require_relative 'class/order'
require_relative 'class/package'
require_relative 'db'
require_relative 'parsing'

def main()
    workbook = RubyXL::Parser.parse("Orders.xlsx")
    orders = []
    packages = []
    parse_file(orders, workbook, packages)
    #print_orders(orders)
    insert_db(orders, packages)
end

main()




