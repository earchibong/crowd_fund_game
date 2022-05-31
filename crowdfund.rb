require_relative 'project'
require_relative 'fund_request'

project1 = Project.new('ABC', 3400, 10000)
project2 = Project.new('EFG', 1400, 5700)
project3 = Project.new('KLM', 4000)
project4 = Project.new('XYZ', 500, 4500)
project5 = Project.new('OPQ', 2000, 8000)

projects = Fund_request.new('vc_friendly_startup_projects')
projects.add_project(project1)
projects.add_project(project2)
projects.add_project(project3)
projects.add_project(project4)
projects.add_project(project5)
projects.request_funding