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