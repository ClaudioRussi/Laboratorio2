class Player

  attr_accessor :ci, :name, :birthdate, :position, :state, :yellow_cards

  def initialize(ci, name, birthdate, position)
  	@position = position
  	@ci = ci
  	@name = name
  	@birthdate = birthdate
  	@state = 'available'
  end

end
