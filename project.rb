require_relative 'pledge_pool'

class Project
    attr_reader :funding, :target
    attr_accessor :name
 
    def initialize(name, funding = 0, target)
        @name = name
        @funding = funding
        @target = target
        @received_pledge = Hash.new(0)
    end
 
    def time
        current_time = Time.new
        current_time.strftime('%I:%M %p')
    end
 
    def funds_needed
        @target - @funding
    end
 
    def to_s
        "Project #{@name} has $#{total_funds} in funding towards a goal of $#{@target}."
    end
 
    def add_funds
       @funding += 25
       puts "Project #{@name} got more funds!"
    end
 
    def remove_funds
        @funding -= 15
        puts "Project #{@name} lost some funds!"
    end
 
    def fully_funded?
        @funding >= @target
    end
 
    def received_pledge(pledge)
        @received_pledge[pledge.name] += pledge.amount
        puts "#{@name} received a #{pledge.name} pledge worth $#{pledge.amount}."
        puts "#{@name}'s pledges: #{@received_pledge}"
    end

    def pledges
      @received_pledge.values.reduce(0, :+)
    end
 
    def total_funds
      @funding + pledges
    end
    
    def each_received_pledge
      @received_pledge.each do |name, amount|
        yield Pledge.new(name, amount)
      end
    end
    
    def self.from_csv(string)
      name, funding, target = string.split(',')
      project = Project.new(name, Integer(funding), Integer(target))
    end
end

project1 = Project.new('ABC', 3400, 10000)
project2 = Project.new('EFG', 1400, 5700)
project3 = Project.new('KLM', 4000)

if __FILE__ == $0
  project1.remove_funds
  project2.add_funds
  puts project3.name
  puts project2.target
  puts project1.funding
  puts project1
  puts project3
end 
