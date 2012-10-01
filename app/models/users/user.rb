require '../../models/items/item'

#user has a name and an amount and can buy active items
#if amount is not enough, the transaction fails
module Users
class User

  #class variable
  @@userList = Array.new
  @@allItemList = Array.new

  #instance variables
  attr_accessor :name, :amount, :itemList

  def self.named( name )
    user = self.new
    user.name = name
    user
  end

  def initialize
    self.amount = 100
    self.itemList = Array.new
  end

  def self.all
    @@userList
  end

  def self.by_name name
    @@userList.detect {|user| user.name == name }
  end

  # add the instance to the list of users
  def save
    @@userList.push self
    self
  end

  def to_s
    name
  end


  def add_item( item )
    @@allItemList.push( item )
    itemList.push(item)
  end

  def remove_item( item )
    itemList.delete(item)
  end

  def list_all_users
    userList.each do |user|
      user.to_s
    end
  end

  def list_items_to_sell
    itemList.each do |item|
      if item.active
        item.to_s
      end
    end
  end

  def list_all_items_of_user
    itemList.each { |item| item.to_s }
  end

  def self.all_items
    @@allItemList
  end

  def buy_item( item, from )
    if item.active
      if self.amount-item.price >= 0
        from.amount += item.price
        self.amount -= item.price
        self.add_item(item)
        item.change_owner(self)
        from.remove_item(item)
        item.active = false
        print "transfer succeeded\n"
      else print "amount not enough\n"
      end
    else print "inactive item\n"
    end
  end
end
end

