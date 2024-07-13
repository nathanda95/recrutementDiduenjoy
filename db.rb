require 'pg'

#INSERT INTO orders (orderid, odername) VALUES (1, 'toto');
#insert into packages (packageid, orderid) VALUES (1, 2);
#query = "INSERT INTO items (itemid, name, price, ref, packageid, warranty, duration) VALUES ($1, $2, $3, $4, $5, $6, $7)"
#conn.exec_params(query, [orders[-1].items[-1].itemId, orders[-1].items[-1].name, orders[-1].items[-1].price.to_i, orders[-1].items[-1].ref, orders[-1].items[-1].packageId.to_i, orders[-1].items[-1].warranty, orders[-1].items[-1].duration])

def create_order(conn, orders)
    orders.each do |order|
        query = "INSERT INTO orders (orderid, odername) VALUES ($1, $2)"
        conn.exec_params(query, [order.id, order.name])
    end
end

def create_package(conn, packages)
    packages.each do |package|
        query = "INSERT INTO packages (packageid, orderid) VALUES ($1, $2)"
        conn.exec_params(query, [package.id, package.orderid])
    end
end

def create_item(conn, orders)
    orders.each do |order|
        order.items.each do |item|
            query = "INSERT INTO items (itemid, name, price, ref, packageid, warranty, duration) VALUES ($1, $2, $3, $4, $5, $6, $7)"
            conn.exec_params(query, [item.itemId, item.name, item.price.to_i, item.ref, item.packageId.to_i, item.warranty, item.duration])
        end
    end
end

def insert_db(orders, packages)
    conn = PG.connect(
        host: 'localhost',
        port: 5432,
        dbname: 'didu',
        user: 'due',
        password: ''
    )
    create_order(conn, orders)
    create_package(conn, packages)
    create_item(conn, orders)
    conn.close
end