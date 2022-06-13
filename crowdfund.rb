require_relative 'project'
require_relative 'fund_request'

=begin
project1 = Project.new('ABC', 3400, 10000)
project2 = Project.new('EFG', 1400, 5700)
project3 = Project.new('KLM', 4000)
project4 = Project.new('XYZ', 500, 4500)
project5 = Project.new('OPQ', 2000, 8000)
=end
vc_fund = Fund_request.new('vc_friendly_startup_projects')
#vc_fund.add_project(project1)
#vc_fund.add_project(project2)
#vc_fund.add_project(project3)
#vc_fund.add_project(project4)
#vc_fund.add_project(project5)
#vc_fund.request_funding(4)
#vc_fund.funding_stats
vc_fund.load_projects(ARGV.shift || 'projects.csv')

loop do
  puts "how many funding rounds would you like? (enter a number or 'q' to quit)"
  answer = gets.chomp.downcase
  case answer
  when /^\d+$/ then vc_fund.request_funding(answer.to_i)
  when 'q', 'quit', 'exit' then vc_fund.funding_stats
    break
  else
    puts "please enter a number of rounds to play or 'q' to exit the game"
  end
end
vc_fund.save_high_scores