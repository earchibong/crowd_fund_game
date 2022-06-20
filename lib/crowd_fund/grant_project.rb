require_relative 'project'

module CrowdFund
  class GrantProject < Project
    def remove_funds
      @funding -= 0
      puts "#{@name} has not lost or gained any new funds"
    end
  end
end

if __FILE__ == $0
  grant = GrantProject.new('TBA', 150, 1500)
  
  puts "#{grant.name} has $#{grant.total_funds} of funding towards a goal of $#{grant.target}"
  grant.remove_funds
  puts "#{grant.name} has $#{grant.total_funds} of funding towards a goal of $#{grant.target}"
end
  