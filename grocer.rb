require "pry"

def consolidate_cart(cart)

  consolidated_cart = {}

  cart.each_with_index do |item|
    item.each do |key, value|
      if consolidated_cart.has_key?(key)
        consolidated_cart[key][:count] += 1
      else
        consolidated_cart[key] = value
        consolidated_cart[key][:count] = 1

      end
    end
  end
  puts consolidated_cart
end
    

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
