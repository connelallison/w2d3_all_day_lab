require('minitest/autorun')
require('minitest/rg')
require_relative('../pub.rb')

class PubTest < MiniTest::Test

  def setup

    @drink_1 = Drink.new("Amstel", 410, 2, 10)
    @drink_2 = Drink.new("Tennants", 350, 2, 0)
    @drink_3 = Drink.new("Whisky", 300, 4, 7)
    @drink_4 = Drink.new("Rum & Coke", 370, 3, 5)
    @drinks = [@drink_1, @drink_2, @drink_3, @drink_4]
    @food_1 = Food.new("Nuts", 100, 0, 10)
    @food_2 = Food.new("Chips", 300, 2, 8)
    @food_3 = Food.new("Pie", 500, 3, 5)
    @food_4 = Food.new("Fish Supper", 700, 4, 0)
    @foods = [@food_1, @food_2, @food_3, @food_4]

    @customer_1 = Customer.new("Kev", 2000, 32, 0)
    @customer_2 = Customer.new("Amit", 3000, 35, 18)
    @customer_3 = Customer.new("Max", 1000, 15, 0)
    @customer_4 = Customer.new("Rab", 0, 26, 4)
    @customer_5 = Customer.new("Jamie", 2000, 27, 9)

    @pub = Pub.new("The State", 10000, @drinks, @foods)

  end

  def test_food_stock()
    assert_equal(@pub.food_stock,{
    @food_1 => 10,
    @food_2 => 8,
    @food_3 => 5,
    @food_4 => 0
    })
  end

  def test_drink_stock()
    assert_equal(@pub.drink_stock,{
      @drink_1 => 10,
      @drink_2 => 0,
      @drink_3 => 7,
      @drink_4 => 5
      })
  end

  def test_customer_buys_a_drink_success()
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)
    @customer_1.buy_drink(@pub, @drink_1)
    assert_equal(@customer_1.drunkenness, 2)
    assert_equal(@customer_1.wallet, 1590)
    assert_equal(@pub.till, 10410)
    assert_equal(@pub.drink_stock[@drink_1], 9)
  end

  def test_customer_buys_a_drink_wasted()
    assert_equal(@customer_2.drunkenness, 18)
    assert_equal(@customer_2.wallet, 3000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)
    @customer_2.buy_drink(@pub, @drink_1)
    assert_equal(@customer_2.drunkenness, 18)
    assert_equal(@customer_2.wallet, 3000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)

  end

  def test_customer_buys_a_drink_underage()
    assert_equal(@customer_3.drunkenness, 0)
    assert_equal(@customer_3.wallet, 1000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)
    @customer_3.buy_drink(@pub, @drink_1)
    assert_equal(@customer_3.drunkenness, 0)
    assert_equal(@customer_3.wallet, 1000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)

  end

  def test_customer_buys_a_drink_skint()
    assert_equal(@customer_4.drunkenness, 4)
    assert_equal(@customer_4.wallet, 0)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)
    @customer_4.buy_drink(@pub, @drink_1)
    assert_equal(@customer_4.drunkenness, 4)
    assert_equal(@customer_4.wallet, 0)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)

  end

  def test_customer_buys_a_drink_edge_success()
    assert_equal(@customer_5.drunkenness, 9)
    assert_equal(@customer_5.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_1], 10)
    @customer_5.buy_drink(@pub, @drink_1)
    assert_equal(@customer_5.drunkenness, 11)
    assert_equal(@customer_5.wallet, 1590)
    assert_equal(@pub.till, 10410)
    assert_equal(@pub.drink_stock[@drink_1], 9)
  end

  def test_customer_buys_a_drink_edge_tight_success()
    assert_equal(@customer_5.drunkenness, 9)
    assert_equal(@customer_5.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_4], 5)
    @customer_5.buy_drink(@pub, @drink_4)
    assert_equal(@customer_5.drunkenness, 12)
    assert_equal(@customer_5.wallet, 1630)
    assert_equal(@pub.till, 10370)
    assert_equal(@pub.drink_stock[@drink_4], 4)
  end

  def test_customer_buys_a_drink_edge_kb()
    assert_equal(@customer_5.drunkenness, 9)
    assert_equal(@customer_5.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_3], 7)
    @customer_5.buy_drink(@pub, @drink_3)
    assert_equal(@customer_5.drunkenness, 9)
    assert_equal(@customer_5.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_3], 7)
  end

  def test_customer_buys_a_drink_out_of_stock()
      assert_equal(@customer_3.drunkenness, 0)
      assert_equal(@customer_3.wallet, 1000)
      assert_equal(@pub.till, 10000)
      assert_equal(@pub.drink_stock[@drink_2], 0)
      @customer_3.buy_drink(@pub, @drink_2)
      assert_equal(@customer_3.drunkenness, 0)
      assert_equal(@customer_3.wallet, 1000)
      assert_equal(@pub.till, 10000)
      assert_equal(@pub.drink_stock[@drink_2], 0)
    end

  def test_customer_buys_a_drink_not_stocked()
    assert_equal(@customer_2.drunkenness, 18)
    assert_equal(@customer_2.wallet, 3000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_5], nil)
    @customer_2.buy_drink(@pub, @drink_5)
    assert_equal(@customer_2.drunkenness, 18)
    assert_equal(@customer_2.wallet, 3000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.drink_stock[@drink_5], nil)
  end

  def test_customer_buys_food_success()
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_2], 8)
    @customer_1.buy_food(@pub, @food_2)
    assert_equal(@customer_1.drunkenness, -2)
    assert_equal(@customer_1.wallet, 1700)
    assert_equal(@pub.till, 10300)
    assert_equal(@pub.food_stock[@food_2], 7)
  end

  def test_customer_buys_food_skint()
    assert_equal(@customer_4.drunkenness, 4)
    assert_equal(@customer_4.wallet, 0)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_2], 8)
    @customer_4.buy_food(@pub, @food_2)
    assert_equal(@customer_4.drunkenness, 4)
    assert_equal(@customer_4.wallet, 0)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_2], 8)
  end

  def test_customer_buys_food_out_of_stock()
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_4], 0)
    @customer_1.buy_food(@pub, @food_4)
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_4], 0)
  end

  def test_customer_buys_food_not_stocked()
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_5], nil)
    @customer_1.buy_food(@pub, @food_5)
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_5], nil)
  end

  def test_customer_buys_food_hits_min_drunkenness()
    assert_equal(@customer_1.drunkenness, 0)
    assert_equal(@customer_1.wallet, 2000)
    assert_equal(@pub.till, 10000)
    assert_equal(@pub.food_stock[@food_2], 8)
    @customer_1.buy_food(@pub, @food_2)
    assert_equal(@customer_1.drunkenness, -2)
    assert_equal(@customer_1.wallet, 1700)
    assert_equal(@pub.till, 10300)
    assert_equal(@pub.food_stock[@food_2], 7)
    assert_equal(@pub.food_stock[@food_3], 5)
    @customer_1.buy_food(@pub, @food_3)
    assert_equal(@customer_1.drunkenness, -4)
    assert_equal(@customer_1.wallet, 1200)
    assert_equal(@pub.till, 10800)
    assert_equal(@pub.food_stock[@food_3], 4)
  end 
end
