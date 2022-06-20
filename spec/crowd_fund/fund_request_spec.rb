require 'crowd_fund/fund_request'
require 'crowd_fund/spec_helper'
require 'crowd_fund/die'

module CrowdFund
  describe Fund_request do
    before do
      @fund_request = Fund_request.new('vc_friendly_startup_projects')
      @funding = 1000
      @target = 12000
      @project = Project.new("ABC", @funding, @target)
      
      @fund_request.add_project(@project)
    end
    
    it "adds funds to a project if an even number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(6)
      @fund_request.request_funding(2)
      @project.funding.should == @funding + 25 * 2
    end
    
    it "removes funds from project if an odd number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      @fund_request.request_funding(2)
      @project.funding.should == @funding - 15 * 2
    end
    
    it "assigns a pledge for money during a project's turn" do
      fund = Fund_request.new('vc_friendly_startup_projects')
      project = Project.new('ABC', 3400, 10000)
  
      fund.add_project(project)
  
      fund.request_funding(1)
  
      project.pledges.should_not be_zero
    end 
      
  end
end
