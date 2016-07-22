class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_total = 0.hash
    each_with_index do | el, idx |
      hash_total ^= (el.hash + idx.hash)
    end
    hash_total
  end
end
#
class String
  def hash
    chars = self.chars.map { |char| char.ord }
    chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_ary = self.map { |el| el}

    cnt = 0.hash

    hash_ary.each do |sub_ary|
      cnt ^= sub_ary.hash
    end

    cnt
  end
end
