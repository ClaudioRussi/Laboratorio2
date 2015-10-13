class Team
  attr_accessor :players, :name

  def initialize(name)
    @name = name
    @players = []
  end

end