class Order
    attr_accessor :items, :name
    def initialize
        @items = []
        @name = nil
    end
end