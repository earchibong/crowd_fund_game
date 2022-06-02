require_relative 'pledge_pool'
require_relative 'spec_helper'

describe Pledge do
  before do
    @pledge = Pledge.new(:bronze, 50)
  end
  
  it "has an attribute name" do
    @pledge.name.should == :bronze
  end
  
  it "has a points attribute" do
    @pledge.amount.should == 50
  end
end

describe PledgePool do
  it "has 3 pledges" do
    PledgePool::PLEDGES.size.should == 3
  end
  
  it "has a bronze pledge worth 50 Dollars" do
    PledgePool::PLEDGES[0].should == Pledge.new(:bronze, 50)
  end

  it "has a silver pledge worth 75 Dollars" do
    PledgePool::PLEDGES[1].should == Pledge.new(:silver, 75)
  end

  it "has a gold pledge worth 100 Dollars" do
    PledgePool::PLEDGES[2].should == Pledge.new(:gold, 100)
  end

  it "returns a pledge" do
    pledges = PledgePool.random

    PledgePool::PLEDGES.should include(pledges)
  end
end