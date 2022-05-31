require_relative 'project'
require_relative 'funding_round'

class Fund_request
    def initialize(name)
        @name = name
        @projects = []
    end
    
    def add_project(project_name)
        @projects << project_name
    end
    
    def request_funding
        puts @name
        puts "There are #{@projects.size} projects you can fund:"
        puts "\n"
        
        @projects.each { |project| puts project }
        puts "\n"
        @projects.each do |project|
            FundingRound.one_round(project)
            puts project
            puts " "
        end
    end
end