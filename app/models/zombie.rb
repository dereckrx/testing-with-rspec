class Zombie < ActiveRecord::Base
  
  validates :name, presence: true
  
  attr_accessor :weapons, :vegetarian, :status, :weapon
  has_many :tweets
  
  def initialize(attrs={})
    super
    self.brains = 0
    self.alive = false
    self.rotting = true
    self.height = 5.9
    @weapons ||= [Weapon.new(name: "Axe"), Weapon.new(name: "Club")]
  end
  
  def hungry?
    true
  end
  
  def swing(weapon)
    true
  end
  
  def decapitate
    @weapon.slice(self, :head)
    self.status = "dead again"
  end
  
end