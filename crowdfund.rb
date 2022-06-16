require_relative 'project'
require_relative 'fund_request'
require_relative 'grant_project'
require_relative 'matching_funds'

=begin
project1 = Project.new("Project ABC", 1000, 5000)
project2 = Project.new("Project LMN", 500, 3000)
project3 = Project.new("Project XYZ", 25, 75)
=end
grant1 = GrantProject.new('TBA', 150, 1500)
match1 = MatchingFunds.new('CVA', 0, 200)

vc_fund = Fund_request.new('vc_friendly_startup_projects')
vc_fund.load_projects(ARGV.shift || 'projects.csv')
=begin
vc_fund.add_project(project1)
vc_fund.add_project(project2)
vc_fund.add_project(project3)
=end
vc_fund.add_project(grant1)
vc_fund.add_project(match1)
=begin
projects.request_funding(4)
projects.print_results
=end

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