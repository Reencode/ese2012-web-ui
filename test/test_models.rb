require 'test/unit'
require '../app/models/users/user'
require '../app/models/items/item'

class TestModels < Test::Unit::TestCase

  def test_unit
    user1 = Users::User.named("Me")
    user2 = Users::User.named("You")
    assert(user1.name.eql?("Me"), "wrong name")
    assert(user1.amount == 100, "wrong initial amount")

    item1 = Items::Item.feature("ESE", 7, user1)
    item2 = Items::Item.feature("PSE", 13, user1)
    item3 = Items::Item.feature("P1", 88, user2)
    item4 = Items::Item.feature("P2", 34, user2)
    assert(item1.name == "ESE", "wrong item name")
    assert(item2.price == 13, "wrong item price")
    assert(item3.active == false, "item is initial inactive")
    assert(item4.owner == user2, "wrong owner")

    user1.add_item(item1)
    user2.add_item(item2)
    user2.add_item(item3)
    user2.add_item(item4)
    assert(user1.list_all_items_of_user == user1.itemList, "added wrong item to system")

    item1.change_state
    item3.change_state
    assert(item1.active == true, "changed state of item")

    user1.buy_item(item4, user2)
    assert(item4.owner == user2, "owner still user2, because cannot buy inactive item")
    assert(user2.amount == 100, "no transfer of money")

    user1.buy_item(item3, user2)
    assert(item3.owner == user1, "bought item has new owner")
    assert(!item3.owner.eql?(user2), "old owner is removed")
    assert(user1.amount == 12, "transfer money")
    assert(user2.amount == 188, "user2 earned money")
    assert(item3.active == false, "after trade, item must be inactive")

    item4.change_state
    user1.buy_item(item4, user2)
    assert(user1.amount == 12, "no changes, not enough money")
    assert(item4.owner == user2, "still the same owner")
    assert(user1.list_all_items_of_user == user1.itemList, "owns 3 items")

  end
end


