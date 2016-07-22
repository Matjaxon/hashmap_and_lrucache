require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if include?(key)
      nil
    else
      @count += 1
      resize! if @count > num_buckets
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    include?(key) ? self[key].delete(key) : nil
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end


  def num_buckets
    @store.length
  end

  def resize!
    new_store = (Array.new(num_buckets * 2) { Array.new })
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % new_store.length] << el
      end
    end
    @store = new_store
  end
end
