require 'crowd_fund/spec_helper'
require 'crowd_fund/grant_project'

module CrowdFund
  describe GrantProject do
    before do
      @initial_funds = 150
      @project = GrantProject.new('TBA', @initial_funds, 1500)
    end
    
    it "does not ever have funds removed" do
      @project.remove_funds
      @project.funding.should == @initial_funds
    end
  end
end
