describe Zombie do
  ### Hooks 
  context "hooks" do 
    let(:zombie) { Zombie.new }
    before { zombie.hungry! }
    it { should be_hungry }
    it { should be_craving_brains }
  end
  
  
 ### Shared examples 
  # in zombie_spec.rb
  it_behaves_like "the undead", Zombie.new # pass undead as param
  
  # in vampire_spec.rb
  let(:undead) { Vampire.new } # Or just define undead here
  it_behaves_like "the undead" 
  
  # in spec/support/shared_examples_for_undead.rb
  shared_examples_for "the undead" do |undead| # leave the block param off if defined in class (vampire)
    undead.pulse.should == false
  end
  
  ### Tags
  context "bla bla", slow: true do 
  end
  it "bla bla", tag_name: true
  
  # Running with or without tags
  # $ rspec --tag tag_name path/file.rb # only run tagged examples tag as tag_name
  # $ rspec --tag ~slow path/file.rb # skips examples tagged as slow
   
end