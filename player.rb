class Player

  attr_accessor :ci, :name, :birthdate, :position

  def initialize(ci, name, birthdate, position)
  	@position = position
  	@ci = ci
  	@name = name
  	@birthdate = birthdate
  end

end
