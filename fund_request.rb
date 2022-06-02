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
  
  def name_and_funding(project)
    puts "#{project.name} : current funding - $#{project.funding}"
  end
    
  def request_funding(rounds)
    puts "\n#{@name}"
    puts "\nThere is/(are) #{@projects.size} project(s) you can fund:"
        
    @projects.each { |project| puts project }
    puts "\n"
    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @projects.each do |project|
        FundingRound.one_round(project)
        puts project
        puts "\n"
      end
    end
  end
    
  def funding_stats
    fully_funded = @projects.select { |project| project.fully_funded? }
    under_funded = @projects.reject { |project| project.fully_funded? }
    
    puts "\n#{@name} stats:"
    puts "\n#{fully_funded.size} fully funded projects:"
    fully_funded.each { |project| name_and_funding(project) }

    puts "\n#{under_funded.size} under funded projects:"
    under_funded.each { |project| name_and_funding(project) }
    
    sorted_projects = under_funded.sort { |a,b| b.funds_needed <=> a.funds_needed }
    puts "\n#{@name} - Outstanding Funds Needed:"
    sorted_projects.each do  |project|
      formatted_name = project.name.ljust(20, '.')
      puts "#{formatted_name}: #{project.funds_needed}"
    end
  end
end