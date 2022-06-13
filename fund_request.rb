require_relative 'project'
require_relative 'funding_round'
require 'csv'

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
  
  def load_projects(from_file)
    CSV.foreach(from_file) do |row|
      project = Project.new(row[0], row[1].to_i)
      add_project(project)
    end

    #File.readlines(from_file).each do |line|
      #name, funding, target = line.split(',')
      #project = Project.new(name, Integer(funding), Integer(target))
      #add_project(Project.from_csv(line))
    #end
  end
  
  def high_score_entry(project)
    formatted_name = project.name.ljust(20, '.')
    "#{formatted_name}: #{project.funds_needed}"
  end
  
  def save_high_scores(to_file="high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@name} High Scores:"
      @projects.each do |project|
        file.puts high_score_entry(project)
      end
    end
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
      puts high_score_entry(project)
    end
    
    @projects.each do |project|
      puts "\n#{project.name}'s fund totals:"
      project.each_received_pledge do |pledge|
        puts "$#{pledge.amount} total #{pledge.name} pledges"
      end
      puts "$#{project.total_funds} grand total"
    end
  end
end