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
    @project.to_s.should == "Project ABC has $1000 in funding towards a goal of $5000. $4000 to reach the goal."
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
end
