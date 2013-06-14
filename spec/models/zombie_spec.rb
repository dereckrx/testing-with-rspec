require "spec_helper"
=begin
### Rails 
For rails use $ rails generate rspec:install (Creates a rails specific spec_helper)
Run all specs $ rspec
Run spec dir $ rspec spec/models/
Run specific file $ rspec spec/models/zombie_spec.rb
Run single spec $ rspec spec/models/zombie_spec.rb:4

### Ruby only
For use with a non rails project use $ rspec --init
Run with $ rspec spec/lib/zombie_spec.rb

=end
describe Zombie do
  
  ### Expectations 
  it "is invalid without a name" do 
    zombie = Zombie.new
    zombie.should_not be_valid
  end
  
  it "is named Ash" do
    zombie = Zombie.new(name: "Ash")
    zombie.name.should == "Ash" # this is an expectation
  end
  
  it "has a name that matches 'Ash Clone'" do 
    zombie = Zombie.new(name: "Ash Clone 1")
    zombie.name.should match(/Ash Clone \d/)
  end
  
  it "has no brains" do 
    zombie = Zombie.new
    zombie.brains.should < 1 # modifer is "should" matcher is "<"
  end
  
  it "is not alive" do 
    zombie = Zombie.new
    zombie.alive.should == false # modifer is "should" matcher is "=="
    # Or zombie.alive.should be_false
  end
  
  it "is rotting" do 
    zombie = Zombie.new
    zombie.rotting.should == true
    # Or zombie.rotting.should be_true
  end
  
  it "is taller then five feet" do 
    zombie = Zombie.new
    zombie.height.should > 5 
    # or zombie.height.should be > 5
    # or zombie.height.should_not be == 5
  end
  
  it "is hungry" do 
    zombie = Zombie.new
    zombie.should be_hungry # for predicate methods .hungry?
  end
  
  it "includes tweets" do 
    tweet1 = Tweet.new(status: "Uuuhhh")
    tweet2 = Tweet.new(status: "Arrrggg")
    zombie = Zombie.new(name: "Ash", tweets: [tweet1, tweet2])
    zombie.tweets.should include(tweet1)
    zombie.tweets.should include(tweet2) # ensure is part of an array
  end
  
  it "starts with two weapons" do 
    zombie = Zombie.new(name: "Ash")
    # zombie.weapons.count.should == 2
    zombie.should have(2).weapons
    # have(n)
    # have_at_least(n)
    # have_at_most(n)
  end
  
  it "changes the number of Zombies" do 
    zombie = Zombie.new(name: "Ash")
    expect { zombie.save }.to change { Zombie.count }.by(1)
    # by(n)
    # from(n)
    # to(2)
    # Chain ex: .from(1).to(5)
  end
  
  it "raises an error if saved without a name" do
    zombie = Zombie.new 
    expect { zombie.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
    # to
    # not_to
    # to_not
  end
  
  it "responds to name" do 
    #zombie = Zombie.new
    #zombie.should respond_to(:name)
    #subject.should respond_to(:name) # subject instatiates zombie if name in desc block
    should respond_to(:name) # auto subject
  end
  # OR 
  it { should respond_to(:name) } # Short hand
  
  it { subject.name.should == nil }
  # Better
  its(:name) { should == nil } # More shorthand
  
  its("weapons.length") { should == 2 }
  
  
  ### Context and subject 
  context "when hungry" do 
    # it 'craves brains'
    context 'with a veggie preference' do 
      let(:zombie) { Zombie.new(vegetarian: true, weapons: [axe]) } # Define subject for this context
      let(:axe) { Weapon.new(name: "axe") }
      subject { zombie } # Or just do subject(:zombie) at first line
      
      its(:weapons) { should include(axe) }
      
      it "can use its axe" do
        zombie.swing(axe).should == true # Zombie is subject, but can use its name now
      end
    end
  end
  
=begin  # Nice clean example
  let(:zombie) { Zombie.create }
  subject { zombie } 
  
  its(:name) { should be_nil? }
  it { should be_craving_brains }
  it "should not be hungry after eating brains" do 
    expect { zombie.eat(:brains) }.to change { zombie.hungry? }.from(true).to(false)
  end
=end

end