def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  len = collection.length()
  count = 0
  hash = Hash.new
  while count < len
    hash = collection[count]
    if(hash[:item] == name)
      return hash
    end
    count += 1

  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  len = cart.length()
  count = 0
  hash = Hash.new
  visited = []
  new_collection = []

  while count < len
    hash = cart[count]

    if(visited.include?(hash[:item]))
      new_len = new_collection.length()
      new_count = 0
      while new_count < new_len
        temp_hash = new_collection[new_count]

        if(temp_hash[:item] == hash[:item])
          temp_hash[:count] = temp_hash[:count] + 1
          new_collection[new_count] = temp_hash
          break
        end
        new_count += 1
      end
    else
      new_hash = {:item => hash[:item], :price => hash[:price],
      :clearance =>  hash[:clearance], :count => 1}
      new_collection.push(new_hash)
      visited.push(hash[:item])

    end
    count += 1

  end
  return new_collection
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


  len = coupons.length()
  c = 0
  while c < len
    coup_h = coupons[c]
    c_len = cart.length()
    i = 0
    coup_item = coup_h[:item]
    while i < c_len
      cart_h = cart[i]
      cart_item = cart_h[:item]

      if(cart_item == coup_item)

        #creates coupon name
        coup_name = cart_item + " W/COUPON"


        num_of_items = cart_h[:count]
        coup_num = coup_h[:num]

        #checks base case if you can apply the coupon
        if(num_of_items < coup_num)
          break
        end

        coup_cost = coup_h[:cost]
        coup_cost_per = (coup_cost / coup_num)

        #number of items applicable for coupon
        num_aplic = (num_of_items/coup_num)
        num_aplic = num_aplic*coup_num
        #num of items left in cart
        num_left = num_of_items - num_aplic
        #builds coupon hash
        item_w_coup = {:item => coup_name, :price => coup_cost_per,
        :clearance => cart_h[:clearance], :count => num_aplic}
        cart_h[:count] = num_left
        cart[i] = cart_h
        cart.push(item_w_coup)
        break
      end
      i += 1
    end

    c += 1
  end

  return cart

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  len = cart.length()
  counter = 0
  hash = Hash.new
  while counter < len
    hash = cart[counter]
    if(hash[:clearance] == true)
      reduced_price = hash[:price] - (hash[:price]*0.2).round(2)
      temp_hash = hash
      temp_hash[:price] = reduced_price
      cart[counter] = temp_hash
    end
    counter += 1

  end

  return cart

end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  print cart
  print "\n\n"
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)


  total = 0
  len = cart.length()
  counter = 0
  hash = Hash.new
  while counter < len
    hash = cart[counter]
    price = hash[:price]
    sub_total = price*hash[:count]
    total = total + sub_total
    counter += 1
    print hash
    print "\n<----------------------------------------------------------------------->\n"
    print "price  = "
    print price
    print " \ncount = "
    print hash[:count]
    print "\nsub total = "
    print sub_total
    print "\ntotal = "
    print total
    print "\n<----------------------------------------------------------------------->\n"

  end
  if(total > 100)
    total = total - ((total*0.1).round(2))
  end
  print "\n<----------------END--------------------------------------------------->\n"
  return total


end
