require_relative 'die'
require_relative 'project'

module FundingRound
  def self.one_round(project)
    die = Die.new
    number_rolled = die.roll
    number_rolled.even? ? project.add_funds : project.remove_funds
  end
end