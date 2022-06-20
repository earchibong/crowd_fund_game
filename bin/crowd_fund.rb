require_relative '../lib/crowd_fund/project'
require_relative '../lib/crowd_fund/fund_request'
require_relative '../lib/crowd_fund/grant_project'
require_relative '../lib/crowd_fund/matching_funds'

grant1 = CrowdFund::GrantProject.new('TBA', 150, 1500)
match1 = CrowdFund::MatchingFunds.new('CVA', 0, 200)

vc_fund = CrowdFund::Fund_request.new('vc_friendly_startup_projects')
default_project_file = File.join(File.dirname(__FILE__), 'projects.csv')
vc_fund.load_projects(ARGV.shift || default_project_file)

vc_fund.add_project(grant1)
vc_fund.add_project(match1)


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