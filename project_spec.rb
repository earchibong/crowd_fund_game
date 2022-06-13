require_relative 'project'
require_relative 'spec_helper'

describe Project do
  before do
    @target_funding = 5000
    @funding_amount = 1000
    @project = Project.new('ABC', @funding_amount, @target_funding)
    $stdout = StringIO.new
  end
    
  it "has an initial target funding amount" do
    @project.target.should == @target_funding
  end
  
  it "computes the total outstanding funding as target funding minus funding amount" do
    @project.funds_needed.should == @target_funding - @funding_amount
  end
  
  it "has a string representation" do
    @project.received_pledge(Pledge.new(:bronze, 50))
    @project.received_pledge(Pledge.new(:bronze, 50))

    @project.to_s.should == "Project ABC has $1100 in funding towards a goal of $5000."
  end
  
  it "increases funds by 25 when funds are added" do
    @project.add_funds
    @project.funding.should == @funding_amount + 25
  end
  
  it "decreases funds by 15 when funds are removed" do
    @project.remove_funds
    @project.funding.should == @funding_amount - 15
  end

  context "created without funding amount" do
    before do
      @project = Project.new('ABC', @target_funding)
    end

    it "has a default funding amount of 0" do
      @project.funding.should == 0
    end
  end
  
  context "when initial funding is greater than target" do
    before do
      @project = Project.new('ABC', 7000, 5000)
    end
    
    it "is fully funded" do
      @project.should be_fully_funded
    end
  end

  context "when inital funding is less than target" do
    before do
      @project = Project.new('ABC', 500, 5000)
    end
    
    it "is under-funded" do
      @project.should_not be_fully_funded
    end
  end
  
  it "computes pledges as the sum of all pledges" do
    @project.pledges.should == 0

    @project.received_pledge(Pledge.new(:silver, 75))
    @project.pledges.should == 75

    @project.received_pledge(Pledge.new(:gold, 100))
    @project.pledges.should == 175

    @project.received_pledge(Pledge.new(:gold, 100))
    @project.pledges.should == 275
  end
  
  it "computes total funds as the sum of a projects funding and pledges" do
    @project.received_pledge(Pledge.new(:gold, 100))
    @project.received_pledge(Pledge.new(:gold, 100))
    
    @project.total_funds.should == 1200
  end
  
  it "yields each received pledges and its total amount" do
  @project.received_pledge(Pledge.new(:gold, 100))
  @project.received_pledge(Pledge.new(:gold, 100))
  @project.received_pledge(Pledge.new(:silver, 75))
  @project.received_pledge(Pledge.new(:bronze, 50))
  @project.received_pledge(Pledge.new(:bronze, 50))
  @project.received_pledge(Pledge.new(:bronze, 50))
  @project.received_pledge(Pledge.new(:bronze, 50))
  @project.received_pledge(Pledge.new(:bronze, 50))

  yielded = []
  @project.each_received_pledge do |pledge|
    yielded << pledge
  end

  yielded.should == [
    Pledge.new(:gold, 200),
    Pledge.new(:silver, 75),
    Pledge.new(:bronze, 250)
    ]
  end
  
  it "can be created from a CSV string" do
    project = Project.from_csv("ABC, 500, 5000")
    
    project.name.should == 'ABC'
    project.funding.should == 500
    project.target.should == 5000
  end
end