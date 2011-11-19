module Presentable

  def self.extended(base)
    base.instance_eval do
      include InstanceMethods
    end
  end

  def presents(*what)
    @presentation = what
  end

  def presentation
    @presentation || []
  end

  module InstanceMethods

    def present
      self.class.presentation.inject({}) do |hash, what|
        hash[what] = send(what)
        hash
      end
    end

  end

end

class Animal
  extend Presentable
end

class Dog < Animal

  def bark
    "woof"
  end

  def jump
    "high jump"
  end

end

class Cat < Animal
  presents :fur, :meow

  def fur
    "soft"
  end

  def meow
    "get lost"
  end

end

dog = Dog.new
puts Dog.presentation.inspect
puts dog.present.inspect

cat = Cat.new
puts Cat.presentation.inspect
puts cat.present.inspect
