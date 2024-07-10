require 'rubyXL'

class Item
    attr_accessor :name, :price, :ref, :packageId, :warranty, :duration, :quantity, :nameCheck, :priceCheck, :refCheck

    def initialize()
        @name = nil
        @price = nil
        @ref = nil
        @packageId = nil
        @warranty = nil
        @duration = nil
        @quantity = nil

        @nameCheck = false
        @priceCheck = false
        @refCheck = false
    end
end

class Order
    attr_accessor :items, :name
    def initialize
        @items = []
        @name = nil
    end
end

def parse_package(item, package)
    item.packageId = package
end

def parse_quantity(item, quantity)
    item.quantity = quantity
end

def parse_label(item, label, val)
    case label
    when "name"
        item.name = val
        item.nameCheck = true
    when "price"
        item.price = val
        item.priceCheck = true
    when "ref"
        item.ref = val
        item.refCheck = true
    when "warranty"
        item.warranty = val
    when "duration"
        item.duration = val
    end
end

def parse_row(item, row)
    parse_label(item, row[2].value, row[3].value)
    parse_package(item, row[0].value)
    parse_quantity(item, row[1].value)
end

def parse_sheet(order, worksheet)
    worksheet.each do |row|
        next if (row == nil)
        if (row[2].value == "name" && order.items[-1].nameCheck == true)
            item = Item.new
            order.items.push(item)
            parse_row(order.items[-1], row)
        elsif (row[2].value == "price" && order.items[-1].priceCheck == true)
            item = Item.new
            order.items.push(item)
            parse_row(order.items[-1], row)
        elsif (row[2].value == "ref" && order.items[-1].refCheck == true)
            item = Item.new
            order.items.push(item)
            parse_row(order.items[-1], row)
        else
            parse_row(order.items[-1], row)
        end
    end
end

def parse_file(orders, workbook)
    workbook.worksheets.each do |sheet|
        order = Order.new
        order.name = sheet.sheet_name
        item = Item.new
        order.items.push(item)
        parse_sheet(order, sheet)
        orders.push(order)
    end
end

def print_order(order)
    order.items.each do |it|
        if (it.name != nil)
            puts "Nom: #{it.name}"
        end
        if (it.price != nil)
            puts "Prix: #{it.price}"
        end
        if (it.ref != nil)
            puts "Ref: #{it.ref}"
        end
        if (it.packageId != nil)
            puts "Package Id: #{it.packageId}"
        end
        if (it.warranty != nil)
            puts "Garantie: #{it.warranty}"
        end
        if (it.duration != nil)
            puts "Durée: #{it.duration}"
        end
        if (it.quantity != nil)
            puts "Quantité: #{it.quantity}"
        end
        puts '--------------'
    end
end

def print_orders(orders)
    orders.each do |order|
        puts '##############'
        puts order.name
        print_order(order)
        puts ''
    end
end

def main()
    workbook = RubyXL::Parser.parse("Orders.xlsx")
    orders = []
    parse_file(orders, workbook)
    print_orders(orders)
end

main()




