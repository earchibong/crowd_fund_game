module Fundable
  def add_funds
    self.funding += 25
    puts "Project #{name} got more funds!"
  end
 
  def remove_funds
    self.funding -= 15
    puts "Project #{name} lost some funds!"
  end
 
  def fully_funded?
    funding >= target
  end
end