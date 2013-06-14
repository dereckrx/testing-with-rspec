=begin 
Stub: for replacing a method with code that returns a specified result
Mock: A stub with with an expectation attached to it. 
=end

describe Zombie do 
  
  let(:zombie) { Zombie.create }
  
  context "#decapitate" do 
    it "calls weapon.slice" do 
      zombie.weapon.should_receive(:slice)
      zombie.decapitate
    end
    it "sets status to dead again" do 
      zombie.weapon.stub(:slice) # Replaces any method calls to .slice in this test with the stub call
      # can stub return values as well
      # head = stub(name: "head") # stub out a body part object hash
      # zombie.weapon.stub(:slice).returns(head)
      zombie.decapitate
      zombie.status.should == "dead again"
    end
  end
  
  target.should_receive(:function).once #.twice, .at_least, etc
  target.should_recieve(:function).with(no_args()) # etc
  
  # Stubbing
  # Replace 
  let(:zombie) { Zombie.new(email: "zombie@gmail.com") } # Where .email is required by test
  # with 
  let(:zombie) { stub(email: "zombie@gmail.com") } # Hash keys turn into methods
  # so zombie.email is still valid
end