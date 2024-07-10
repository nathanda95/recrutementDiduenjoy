def print_orders(orders)
    orders.each do |order|
        puts '##############'
        puts order.name
        print_order(order)
        puts ''
    end
end