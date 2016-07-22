require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

# HashMap get/put operations are O(1)
#Unsorted linked list O(1) for insert and delete

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #if included in cached, just lookup and give back
    qry_link = @map.get(key)
    if qry_link
      update_link!(qry_link)
      return qry_link.val
    else
      proc_val = calc!(key)
      if count == @max
        eject!
      end
      link = @store.insert(key, proc_val) #return the link in our store
      @map.set(key, link) #set the value for the map to the link
      return proc_val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link)
    @store.insert(link.key, link.val)
  end

  def eject!
    head_link = @store.first
    @store.remove(head_link.key)
    @map.delete(head_link.key)
  end
end
