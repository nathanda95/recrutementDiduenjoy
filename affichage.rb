def print_order(order)
    order.items.each do |it|
        if (it.itemId != nil)
            puts "Item id: #{it.itemId}"
        end
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
        puts "Order id: #{order.id}"
        puts '--------------'
        print_order(order)
        puts ''
    end
end