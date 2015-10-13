require_relative 'championship'
require_relative 'team'
require_relative 'player'
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
      return 'Hay equipos que no son par'
    elsif incomplete_team == true
      return 'Hay equipos incompletos'
    else
      return nil
    end
  end

  def championship_start
    @championship.is_started = true
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
    @championship.players_in_championship << Player.new(ci, name, birthdate)
  end

  def add_player_to_team(team_name, player_id)
    
  end

  def player_list
    []
  end

  def team_list
    []
  end

  def matches_list
    []
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