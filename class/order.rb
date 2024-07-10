class Order
    attr_accessor :items, :name, :id
    def initialize
        @items = []
        @name = nil
        @id = nil
    end
end