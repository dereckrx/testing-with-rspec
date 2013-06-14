# in spec/models/zombie_spec.rb
# usage
it 'validates presence of name' do 
  zombie = Zombie.new(name: nil)
  zombie.should validate_presence_of(:name).with_message('been eaten')
end
# end usage
module ValidatePresenceOfAttr
  
  class Matcher
    def initialize(attr)
      @attr = attr
      @message = "can't be blank"
    end
    
    def matches?(model)
      @model = model
      @model.valid?
      errors = @model.errors[@attr]
      errors.any? { |error| error == @message }
      @model.errors.has_key?(@attr)
    end
    
    def with_message(message)
      @message = message
      self
    end
    
    def failure_message
      "#{@model.class} failed to validate :#{@attr} presence."
    end
    
    def negative_failuer_message
      "#{@model.class} validated :#{@attr} presence."
    end
  end
  
  def validate_presence_of(attr)
    Matcher.new(attr)
  end
  
  RSpec.configure do |config|
    config.include ValidatePresenceOfAttr, type: :model
  end
  
end