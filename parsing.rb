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

def parse_row(item, row, package)
    if (row[0] == nil || row[1] == nil || row[2] == nil || row[3] == nil)
        return
    end
    parse_label(item, row[2].value, row[3].value)
    parse_package(item, package)
    parse_quantity(item, row[1].value)
end

def parse_sheet(order, worksheet, packages)
    i = 0
    package = worksheet[0][0].value
    package_save = worksheet[0][0].value
    worksheet.each do |row|
        next if (row == nil || row[0] == nil)
        if (row[0] != nil)
            package_save = package
            package = row[0].value
        end
        if (row[2] != nil && row[2].value == "name" && order.items[-1].nameCheck == true)
            item = Item.new
            item.itemId = order.items[-1].itemId + 1
            otherPackagevar = order.items[-1].packageId
            order.items.push(item)
            if (package != package_save)
                parse_row(order.items[-1], row, otherPackagevar + 1)
                packageNew = Package.new
                packageNew.id = otherPackagevar + 1
                packageNew.orderid = order.id
                packages.push(packageNew)
            else
                parse_row(order.items[-1], row, otherPackagevar)
            end
        elsif (row[2] != nil && row[2].value == "price" && order.items[-1].priceCheck == true)
            item = Item.new
            item.itemId = order.items[-1].itemId + 1
            otherPackagevar = order.items[-1].packageId
            order.items.push(item)
            if (package != package_save)
                parse_row(order.items[-1], row, otherPackagevar + 1)
                packageNew = Package.new
                packageNew.id = otherPackagevar + 1
                packageNew.orderid = order.id
                packages.push(packageNew)
            else
                parse_row(order.items[-1], row, otherPackagevar)
            end
        elsif (row[2] != nil && row[2].value == "ref" && order.items[-1].refCheck == true)
            item = Item.new
            item.itemId = order.items[-1].itemId + 1
            otherPackagevar = order.items[-1].packageId
            order.items.push(item)
            if (package != package_save)
                parse_row(order.items[-1], row, otherPackagevar + 1)
                packageNew = Package.new
                packageNew.id = otherPackagevar + 1
                packageNew.orderid = order.id
                packages.push(packageNew)
            else
                parse_row(order.items[-1], row, otherPackagevar)
            end
        else
            parse_row(order.items[-1], row, order.items[-1].packageId)
        end
        i = i + 1
    end
end

def parse_file(orders, workbook, packages)
    workbook.worksheets.each do |sheet|
        order = Order.new
        order.name = sheet.sheet_name
        item = Item.new
        package = Package.new
        if (orders.size == 0)
            order.id = 0
            item.itemId = 0
            item.packageId = 0
            package.id = 0
            package.orderid = 0
        else
            order.id = orders[-1].id + 1
            item.itemId = orders[-1].items[-1].itemId + 1
            item.packageId = orders[-1].items[-1].packageId + 1
            package.id = item.packageId 
            package.orderid =  order.id
        end
        order.items.push(item)
        packages.push(package)
        parse_sheet(order, sheet, packages)
        orders.push(order)
    end
end
