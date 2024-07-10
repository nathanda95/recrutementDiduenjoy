class Item
    attr_accessor :itemId, :name, :price, :ref, :packageId, :warranty, :duration, :quantity, :nameCheck, :priceCheck, :refCheck

    def initialize()
        @itemId = nil
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