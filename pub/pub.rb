#12 units limit

class Customer

  attr_reader :name, :wallet, :age, :drunkenness

  def initialize(name, wallet, age, drunkenness)
    @name = name
    @wallet = wallet
    @age = age
    @drunkenness = drunkenness
  end

  def buy_drink(pub, drink)
    pub_reply = pub.sell_drink(drink, self)
    if (pub_reply == drink)
      @wallet -= drink.price
      pub.add_money(drink.price)
      @drunkenness += drink.alcohol
    else
      return pub_reply
    end
  end

  def buy_food(pub, food)
    pub_reply = pub.sell_food(food, self)
    if (pub_reply == food)
      @wallet -= food.price
      pub.add_money(food.price)
      @drunkenness -= food.rejuvenation
      if (@drunkenness < -4)
        @drunkenness = -4
      end
    else
      return pub_reply
    end
  end

  def get_drunk(amount)
    @drunkenness += amount
  end

end

class Drink

  attr_reader :name, :price, :alcohol, :quantity

  def initialize(name, price, alcohol, quantity)
    @name = name
    @price = price
    @alcohol = alcohol
    @quantity = quantity
  end

  def reduce_quantity()
    @quantity -= 1
  end

end

class Food

  attr_reader :name, :price, :rejuvenation, :quantity

  def initialize(name, price, rejuvenation, quantity)
    @name = name
    @price = price
    @rejuvenation = rejuvenation
    @quantity = quantity
  end

  def reduce_quantity()
    @quantity -= 1
  end


end

class Pub

  attr_reader :name, :till, :drinks, :foods, :food_stock, :drink_stock

  def initialize(name, till, drinks, foods)
    @name = name
    @till = till
    @drinks = drinks
    @foods = foods
    @food_stock = {}
    @foods.each() { |food| @food_stock[food] = food.quantity }
    @drink_stock = {}
    @drinks.each() { |drink| @drink_stock[drink] = drink.quantity }
  end

  def sell_drink(drink, customer)
    customer_drunkenness = customer.drunkenness()
    if (@drinks.include?(drink))
      if (drink.quantity >= 1)
        if (customer.age >=18)
          if ((customer_drunkenness += drink.alcohol) <= 12)
            if (customer.wallet >= drink.price)
              drink.reduce_quantity
              drink_stock[drink] -= 1
              return drink
            else
              return "You can't afford that drink!"
            end
          else
            return "You've had enough pal!"
          end
        else
          return "Come back when you're older!"
        end
      else
        return "We sell that but don't have any left!"
      end
    else
      return "We don't sell that drink!"
    end
  end


  def sell_food(food, customer)
    if (@foods.include?(food))
      if (food.quantity >= 1)
            if (customer.wallet >= food.price)
              food.reduce_quantity
              food_stock[food] -= 1
              return food
            else
              return "You can't afford that food!"
            end
      else
        return "We sell that but don't have any left!"
      end
    else
      return "We don't sell that food!"
    end
  end


  def add_money(amount)
    @till += amount
  end

end





  @drink_1 = Drink.new("Amstel", 410, 2, 10)
  @drink_2 = Drink.new("Tennants", 350, 2, 2)
  @drink_3 = Drink.new("Whisky", 300, 4, 7)
  @drink_4 = Drink.new("Rum & Coke", 370, 3, 5)
  @drinks = [@drink_1, @drink_2, @drink_3, @drink_4]
  @food_1 = Food.new("Nuts", 100, 0, 10)
  @food_2 = Food.new("Chips", 300, 2, 8)
  @food_3 = Food.new("Pie", 500, 3, 5)
  @food_4 = Food.new("Fish Supper", 700, 4, 4)
  @foods = [@food_1, @food_2, @food_3, @food_4]

  @customer_1 = Customer.new("Kev", 2000, 32, 0)
  @customer_2 = Customer.new("Amit", 3000, 35, 18)
  @customer_3 = Customer.new("Max", 1000, 15, 0)
  @customer_4 = Customer.new("Rab", 0, 26, 4)
  @customer_5 = Customer.new("Jamie", 2000, 27, 9)

  @pub = Pub.new("The State", 10000, @drinks, @foods)

@customer_2.buy_drink(@pub, @drink_1)
