class Team
  attr_accessor :players, :name, :pj, :pg, :pe, :pp, :puntos, :goles

  def initialize(name)
    @name = name
    @players = []
    @goles = 0
    @pj = 0
    @pg = 0
    @pe = 0
    @pp = 0
    @puntos = 0
  end

end