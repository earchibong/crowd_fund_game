class Project
    attr_reader :funding, :target
    attr_accessor :name
    
    def initialize(name, funding = 0, target)
        @name = name
        @funding = funding
        @target = target
    end
    
    def time
        current_time = Time.new
        current_time.strftime('%I:%M %p')
    end
    
    def funds_needed
        @target - @funding
    end
    
    def to_s
        "Project #{@name} has $#{@funding} in funding towards a goal of $#{@target}."
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
