require 'pg'

def insert_db(orders)
    conn = PG.connect(
        host: 'localhost',
        port: 5432,
        dbname: 'didu',
        user: 'due',
        password: ''
    )
    query = "INSERT INTO items (itemid, name, price, ref, packageid, warranty, duration) VALUES ($1, $2, $3, $4, $5, $6, $7)"
    conn.exec_params(query, [0, orders[-1].items[-1].name, orders[-1].items[-1].price.to_i, orders[-1].items[-1].ref, orders[-1].items[-1].packageId.to_i, orders[-1].items[-1].warranty, orders[-1].items[-1].duration])
    conn.close
end