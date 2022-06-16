require_relative 'project'

class MatchingFunds < Project
  def initialize(name, funding=0, target)
    super(name, funding, target)
    @half_funded = target / 2
  end
  
  def half_funded?
    @half_funded <= funding
  end
  
  def add_funds
    if half_funded?
      @funding += ( 25 * 2 )
      puts "#{name} has received at least half of its funding!"
    else
      super
    end
  end
end

if __FILE__== $0
  matching_funds = MatchingFunds.new('CVA', 10, 100)
  3.times { matching_funds.add_funds }
  puts matching_funds.funding
end