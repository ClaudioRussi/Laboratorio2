class Match
  attr_accessor :id, :team_a, :team_b, :team_a_goals, :team_b_goals, :state, :news, :result
  
  def initialize(id, team_a, team_b)
    @id = id
    @team_a = team_a
    @team_b = team_b
    @state = :pending
    @news = []

  end

end