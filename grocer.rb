require 'pry'


def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |produce|
    produce.each do |item, detail|
      if cart_hash[item] == nil
        cart_hash[item] = detail
        cart_hash[item].merge!(:count => 1)
      else
        cart_hash[item][:count] += 1
      end
    end
  end
  cart_hash
end


def apply_coupons(cart, coupons)

    coupons.each do |coupon|
      if cart.has_key?(coupon[:item]) && coupon[:num] <= cart[coupon[:item]][:count]
        key = "#{coupon[:item]} W/COUPON"
        if cart.has_key?(key)
          cart[key][:count] += 1
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[key] = {
            :price => coupon[:cost],
            :clearance => cart[coupon[:item]][:clearance],
            :count => 1
          }
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
  end
cart
end

def apply_clearance(cart)
  cart.each do |produce, properties|
    if properties[:clearance] === true
      properties[:price] = (properties[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  cons_cart = apply_coupons(cons_cart, coupons)
  updated_cart = apply_clearance(cons_cart)
  total_price = 0
  updated_cart.each do |produce, properties|
    total_price += (properties[:price] * properties[:count]).round(2)
  end
  total_price > 100 ? (total_price*0.9).round(2) : total_price
end
