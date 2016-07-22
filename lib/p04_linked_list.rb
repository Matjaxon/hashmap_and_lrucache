class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
    @link_count = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @link_count == 0
  end

  def get(key)
    self.each {|link| return link.val if link.key == key}
    nil
  end

  def include?(key)
    self.each {|link| return true if link.key == key}
    false
  end

  def insert(key, val)
    if include?(key)
      found_link = self.select { |link| link.key == key }.first
      found_link.val = val
      return found_link
    else
      new_link = Link.new(key, val)
      @link_count += 1

      if first.key.nil?
        new_link.next = @tail
        @tail.prev = new_link
        @head = new_link
      elsif last.key.nil?
        new_link.prev = @head
        @head.next = new_link
        @tail = new_link
      else
        new_link.prev = @tail
        @tail.next = new_link
        @tail = new_link
      end
      return new_link
    end
  end

  def remove(key)
    found_link = self.select { |link| link.key == key }.first
    if found_link
      prev_link = found_link.prev
      next_link = found_link.next
      prev_link.next = next_link unless prev_link.nil?
      if found_link == @head
        @head = next_link
      end
      next_link.prev = prev_link unless next_link.nil?
      if found_link == @tail
        @tail = prev_link
      end
      @link_count -= 1
    end
    nil
  end

  def each
    i = 0
    current_link = @head
    while i < @link_count
      yield current_link
      current_link = current_link.next
      i += 1
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
