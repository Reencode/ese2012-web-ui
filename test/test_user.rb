require "test/unit"
require '../app/models/items/item'
require '../app/models/users/user'

include Items
include Users

class UserTest < Test::Unit::TestCase

  def test_has__a_name
    user = User.named("Hannah")
    assert(user.name.to_s.include?("Hannah"), "name is not Hannah!")
  end

  def test_has_name_and_amount
    user = User.named("Hannah")
    user.amount = 234
    assert(user.name.to_s.include?("Hannah"), "name is not Hannah!")
    assert(user.amount == 234, "credit is not 234!")
  end

  def test_has_normal_start_amount
    user = User.named("Heinrich")
    assert(user.amount == 100, "start credit wrong!")
  end

  def test_has_bigger_amount
    user = User.named("Heinro")
    user.amount += 50
    assert(user.amount == 150, "credit is not 150!")
  end

  def test_has_smaller_amount
    user = User.named("Ulrich")
    user.amount -= 50
    assert(user.amount == 50, "credit is not 50!")
  end

  def test_add_item
    # list is empty now
    user = User.named("Serioso")
    assert(user.itemList.length == 0, "sell list is not empty")
    itemX = Item.feature("itemX",300,user)
    user.add_item(itemX)
    assert(user.itemList.include?(itemX), "item was not added!")
  end

  def test_fail_not_enough_credit
    user = User.named("Buyer")
    owner = User.named("Owner")
    item = Item.feature("tooExpensiveItem",5000,owner)
    user.buy_item(item,owner)
    assert(user.itemList.size == 0, "user could have bought the too expensive item!")
  end

  def test_become_owner_at_trade
    user = User.named("Buyer")
    owner = User.named("Owner")
    item = Item.feature("someItem", 100, owner)
    item.active= true
    user.buy_item(item,owner)
    assert(user.itemList.size == 1, "user was not able to buy!")
    assert(item.owner == user, "user is not the owner!")
  end

  def test_transfer_amount_at_trade
    user = User.named("Buyer")
    owner = User.named("Owner")
    item = Item.feature("normalItem",100,owner)
    item.active= true
    user.buy_item(item,owner)
    assert(user.amount == 0, "user has too much credit!")
    assert(owner.amount == 200, "owner has too less credit!")
  end

  def test_removes_from_user
    user = User.named("Buyer")
    owner = User.named("Owner")
    item = Item.feature("normalItem",100,owner)
    item.active= true
    user.buy_item(item,owner)
    assert(owner.itemList.length == 0, "owner still has the item on his list!")
  end

  def test_fail_inactive
    user = User.named("Buyer")
    owner = User.named("Owner")
    item = Item.feature("Whoot",10,owner)
    user.buy_item(item,owner)
    assert(user.itemList.size == 0, "user could have bought the inactive item!")
  end

  def test_all_users
    Users::User.named( 'ese' ).save()
    Users::User.named( 'Joel' ).save()
    Users::User.named( 'Aaron').save()
    # we should have 3 students now

    assert(Users::User.all_users.size == 3, "there are not 3 users in the users list!")
  end

end