require_relative 'die'
require_relative 'project'
require_relative 'pledge_pool'

module FundingRound
  def self.one_round(project)
    die = Die.new
    number_rolled = die.roll
    number_rolled.even? ? project.add_funds : project.remove_funds
    pledge = PledgePool.random
    puts "#{project.name} got a #{pledge.name} pledge worth $#{pledge.amount}"
  end
end