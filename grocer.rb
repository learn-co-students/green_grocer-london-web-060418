def consolidate_cart(cart)
  #create a new hash  name => {price:float, clearance: bool }
  cart_hash = {}
  cart.each do | item_hash |  #items in the array
    item_hash.each do |item_name, item_data|
      if(!cart_hash.key?(item_name))
        cart_hash[item_name] = {}
        cart_hash[item_name] = {price: item_data[:price], clearance: item_data[:clearance], count: 1}
      else
        cart_hash[item_name][:count] = cart_hash[item_name][:count] + 1
      end
    end
  end

  return cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  #{:item => "AVOCADO", :num => 2, :cost => 5.0} ---- coupon hash
  if(coupons.length > 0) then
  coupons.each do |coupon|

    coupon_item_name = coupon[:item]

    if(cart.key?(coupon_item_name)) then

      coupon_name_key = coupon_item_name + " W/COUPON"
      coupon_item_qty = coupon[:num]
      coupon_item_price = coupon[:cost]

      original_clearance_value = cart[coupon_item_name][:clearance]

      if(cart[coupon_item_name][:count] >= coupon_item_qty) then
        if(!cart.key?(coupon_name_key)) then
          cart[coupon_name_key] = { }
          cart[coupon_name_key][:price] = coupon_item_price
          cart[coupon_name_key][:clearance] = original_clearance_value
          cart[coupon_name_key][:count] = 1
        else
          cart[coupon_name_key][:count] = cart[coupon_name_key][:count] + 1
        end

        cart[coupon_item_name][:count] = cart[coupon_item_name][:count] - coupon_item_qty

      end

    end
  end
  end

  return cart

end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if(cart[key][:clearance])
      cart[key][:price] =  sprintf('%.2f', (cart[key][:price] * 0.8)).to_f
    end
  end

  return cart
end

def checkout(cart, coupons = [])
  # code here
  total_costs = 0.0

  total_cart = consolidate_cart(cart)
  total_cart = apply_coupons(total_cart, coupons)
  total_cart = apply_clearance(total_cart)

  total_cart.each do |key, value|
    total_costs += total_cart[key][:price] * total_cart[key][:count]
  end

  total_costs = total_costs > 100.0 ? total_costs * 0.9 : total_costs

  return total_costs
end
