class Championship
  attr_accessor :name, :teams_size, :teams, :is_started, :players_in_championship

  def initialize(teams_size)
    @teams_size = teams_size
    @teams = []
    @is_started = false
    @players_in_championship = []
  end


end