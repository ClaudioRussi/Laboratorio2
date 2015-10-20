require_relative 'championship'
require_relative 'team'
require_relative 'defense'
require_relative 'forward'
require_relative 'goalkeeper'
require_relative 'midfielder'
require_relative 'match'
class Program

  #No entendi para que es necesario este metodo, ya que se puede crear la instancia con set_championship
  def initialize(teams_size=5)
    @championship = Championship.new(teams_size)
  end

  def set_championship(name, teams_size)
    @championship.name = name
    @championship.teams_size = teams_size
  end

  def championship_can_be_played
    
    @championship.teams.each do |team|
      if team.players.size < championship.teams_size
        incomplete_team = true
      end
    end
    if @championship.teams.size == 0
      return 'No hay equipos para jugar!'
    elsif @championship.teams.size % 2 != 0
      return 'El numero de equipos no es par'
    elsif incomplete_team == true
      return 'Hay equipos incompletos'
    else
      return nil
    end
  end

  def championship_start
    contador = 0
    unless @championship.is_started
      @championship.is_started = true
      matches = @championship.teams.combination(2).to_a
      matches.each do |match|
        @Championship.matches << Match.new(contador, match[0], match[1])
        contador = contador + 1
      end

    end
  end

  def championship_name
    @championship.name
  end

  def championship_started?
    @championship.is_started
  end

  def add_team(team_name)
    @championship.teams.each do |team|
      if team.name == team_name
        return 'Ya existe un equipo con ese nombre'
      end
    end
    @championship.teams << Team.new(team_name)
  end

  def add_player(ci, name, birthdate, position)
    @championship.players_in_championship.each do |player|
      if player.ci == ci
        return 'Ya existe un jugador con esa cedula'
      end
    end
    case position 
      when 'Defensa' 
        @championship.players_in_championship << Defense.new(ci,name,birthdate) 

      when 'Arquero' 
        @championship.players_in_championship << GoalKeeper.new(ci,name,birthdate) 

      when 'Volante' 
        @championship.players_in_championship << Midfielder.new(ci,name,birthdate) 

      when 'Delantero' 
        @championship.players_in_championship << Forward.new(ci,name,birthdate) 

     end
  end

  def add_player_to_team(team_name, player_id)
    @championship.players.each do |player|
      if player.ci == player_id
        chosen_player = player
      end
    end
    @championship.teams.each do |team|
      if team.name == team_name
        chosen_team == team
      end
    end

    chosen_team.players.each do |player|
      if player.class == chosen_player.class && player.class == GoalKeeper
        return 'Ese equipo ya tiene un arquero'
      end
    end

    if chosen_team.players.size == @championship.teams_size
      return 'Ese equipo ya esta completo'
    else
      chosen_team.players << chosen_player
    end
  end

  def player_list
    @championship.players_in_championship
  end

  def team_list
    @championship.teams
  end

  def matches_list
    to_return = []
    @championship.matches.each do |match|
      to_return << {id => match.id, description => "#{match.team_a.name} vs #{match.team_b.name}", result => "#{match.team_a_goals} - #{match.team_b_goals}", state => match.state }
    end
    to_return
  end

  def start_match(match_id)
  end

  def end_match(match_id)
  end

  def get_match(match_id)
  end

  def players_list_for_team(team_name)
  end

  def players_without_team
  end

  def available_players_list_for_match(match_id, team_name)
  end

  def add_match_action(match_id, team_name, player_id, action)
  end

  def get_table_data
  end

  def get_news_data
  end
end
