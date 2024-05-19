class NonSafeSingleton
  private_class_method :new
  @instance = nil

  def self.get_instance
    @instance ||= new
  end

  def foo
    puts "object_id: #{object_id}"
  end
end

class SafeSingleton
  private_class_method :new

  @instance = nil
  @mutex = Mutex.new

  def self.get_instance
    return @instance if @instance

    @mutex.synchronize do
      @instance ||= new
    end

    @instance
  end

  def foo
    puts "object_id: #{object_id}"
  end
end


threads = []

15.times do |i|
  threads << Thread.new do
    SafeSingleton.get_instance.foo
  end
end

threads.each(&:join)

puts "All threads have finished"
