
# -*- coding: utf-8 -*-

class Support
  def initialize(name)
    @name = name
    @next_support = nil
  end

  def set_next(next_support)
    @next_support = next_support

    return next_support
  end

  def support(trouble)
    if resolve(trouble)
      done(trouble)
    elsif !@next_support.nil?
      @next_support.support(trouble)
    else
      failure(trouble)
    end
  end

  def to_s
    return "[#{@name}]"
  end

  private
  def resolve(trouble)
  end

  def done(trouble)
    puts "#{trouble} is resolved by #{self}."
  end

  def failure(trouble)
    puts "#{trouble} cannoot be resolved."
  end
end


class NoSupport < Support
  def initialize(name)
    super(name)
  end

  def resolve(trouble)
    return false
  end
end


class LimitSupport < Support
  def initialize(name, limit)
    super(name)
    @limit = limit
  end

  private
  def resolve(trouble)
    return trouble.number < @limit
  end
end


class OddSupport < Support
  def initialize(name)
    super(name)
  end

  private
  def resolve(trouble)
    return trouble.number % 2 == 1
  end
end


class SpecialSupport < Support
  def initialize(name, number)
    super(name)
    @number = number
  end

  private
  def resolve(trouble)
    return trouble.number == @number
  end
end

class Trouble
  def initialize(number)
    @number = number
  end

  attr_reader :number

  def to_s
    return "[Trouble #{@number}]"
  end
end


alice = NoSupport.new("Alice")
bob = LimitSupport.new("Bob", 100)
charlie = SpecialSupport.new("Charlie", 429)
diana = LimitSupport.new("Diana", 200)
elmo = OddSupport.new("Elmo")
fred = LimitSupport.new("Fred", 300)

alice.set_next(bob).set_next(charlie).set_next(diana).set_next(elmo).set_next(fred)

i = 0
while i < 500 do
  alice.support(Trouble.new(i))
  i += 33
end