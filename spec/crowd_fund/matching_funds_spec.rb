require 'crowd_fund/matching_funds'
require 'crowd_fund/spec_helper'

module CrowdFund
  describe MatchingFunds do
    before do
      @initial_funds = 0
      @project = MatchingFunds.new('CVA', @initial_funds, 200)
    end
    
    it "does not match additional funds when project is not funded halfway" do
      3.times { @project.add_funds }
      @project.half_funded?.should be_falsey
    end
    
    it "is funded halfway when it has received half of its target funding" do
      4.times { @project.add_funds }
      @project.half_funded?.should be_truthy
    end
    
    it "gets twice as much added funds when it is funded halfway" do
      7.times { @project.add_funds }
      
      @project.funding.should == (4 * 25) + (3 * 25 * 2)
    end
  end
end
