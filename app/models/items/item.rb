module Items
  #item has an owner, name, price and can be active or inactive
  #bought items change the owner

  class Item
    @@itemList = Array.new
    @@itemId = 1

    attr_accessor :name, :price, :owner, :id, :active

    def self.feature( name, price, owner )
      item = self.new
      item.name = name
      item.price = price
      item.owner = owner
      item.active = false
      item.id = @@itemId
      @@itemId += 1
      item
    end


    def self.all
      @@itemList
    end

    def save
      @@itemList.push(self)
    end

    def change_owner( owner )
      self.owner = owner
    end

    def change_state
      if self.active == true
        self.active=false
      else
        self.active=true
      end
    end

    def self.by_id id
      @@itemList.find{|item| item.id.to_i == id }
    end

    def to_s
      "Id: #{id}\tName: #{name}\tPrice: #{price}\tOwner: #{owner.name}\n"
    end
  end
end