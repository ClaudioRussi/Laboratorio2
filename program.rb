require_relative 'championship'
require_relative 'team'
require_relative 'defense'
require_relative 'forward'
require_relative 'goalkeeper'
require_relative 'midfielder'
require_relative 'match'
require_relative 'converter'
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
    incomplete_team = false
    @championship.teams.each do |team|
      if team.players.size < @championship.teams_size
        incomplete_team = true
      end
    end
    if @championship.teams.size == 0
      return 'No hay equipos para jugar!'
    elsif @championship.teams.size % 2 != 0
      return 'El numero de equipos no es par'
    elsif incomplete_team
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
        @championship.matches << Match.new(contador, match[0], match[1])
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
      if team.name== team_name
        return 'Ya existe un equipo con ese nombre'
      end
    end
    @championship.teams << Team.new(team_name)
    nil
  end

  def add_player(ci, name, birthdate, position)
    @championship.players_in_championship.each do |player|
      if player.ci == ci
        return 'Ya existe un jugador con esa cedula'
      end
    end
    case position 
      when 'Defensa' 
        @championship.players_in_championship << Defense.new(ci,name,birthdate,position) 
        nil
      when 'Arquero' 
        @championship.players_in_championship << GoalKeeper.new(ci,name,birthdate,position)          
        nil
      when 'Volante'
        @championship.players_in_championship << Midfielder.new(ci,name,birthdate,position) 
        nil
      when 'Delantero'
        @championship.players_in_championship << Forward.new(ci,name,birthdate,position)
        nil
     end
  end

  def add_player_to_team(team_name, player_id)
    selected_player = Identifier.identify(player_id, @championship.players_in_championship)
    selected_team = Identifier.identify(team_name, @championship.teams)

    selected_team.players.each do |player|
      if player.position == selected_player.position && player.position == 'Arquero'
        return 'Ese equipo ya tiene un arquero'
      end
    end

    if selected_team.players.size == @championship.teams_size
      return 'Ese equipo ya esta completo'
    else
      selected_team.players << selected_player
    end
    nil
  end

  def player_list
    player_list_to_p=[]
    @championship.players_in_championship.each do |player|
      player_list_to_p << Converter.player_converter(player)
    end
    player_list_to_p
  end

  def team_list
    team_list=[]
    @championship.teams.each do |team|
      team_list << Converter.team_converter(team)
    end
    team_list
  end

  def matches_list
    to_return = []

    @championship.matches.each do |match|
      case match.state 
      when 'finalizado'
        match_state = :ended
      when 'en juego'
        match_state = :in_progress
      when 'pendiente'
        match_state = :pending
      end
      to_return << {id => match.id, description => "#{match.team_a.name} vs #{match.team_b.name}", result => "#{match.team_a_goals} - #{match.team_b_goals}", state => match_state }
    end
    to_return
  end

  def start_match(match_id)
    championship.matches.each do |match|
      if match.id == match_id
        match.state = 'in_progress'
        match.news << "El partido #{match.team_a.name} vs #{match.team_b.name} ha comenzado"
      end
    end
  end

  def end_match(match_id)
    championship.matches.each do |match|
      if match.id == match_id
        match.state = 'ended'
        match.news << "El partido #{match.team_a.name} vs #{match.team_b.name} ha finalizado"
      end
    end
  end

  def get_match(match_id)
    championship.matches.each do |match|
      if match.id == match_id
        case match.state
        when 'finalizado'
          match_state = :ended
        when 'en juego'
          match_state = :in_progress
        when 'pendiente'
          match_state = :pending
        end
        return {state => match_state, description => "#{match.team_a.name} vs #{match.team_b.name}", result => match.result, team_a => match.team_a, team_b => match.team_b, news => match.news}
      end
    end
  end

  def players_list_for_team(team_name)
    players_to_return = []
    selected_team = Identifier.identify(team_name, @championship.teams)
    selected_team.players.each do |player|
      players_to_return << Converter.player_converter(player)
    end
    return players_to_return
  end

  def players_without_team
    players_in_team = []
    available_players = []
    @championship.teams.each do |team|
      team.players.each do |player_in_team|
        players_in_team << player_in_team
      end
    end
    @championship.players_in_championship.each do |player|
      unless players_in_team.include?(player)
        available_players << Converter.player_converter(player)
      end
    end
    available_players
  end

  def available_players_list_for_match(match_id, team_name)
    to_return = []
    @championship.matches.each do |match|
      if match.id == match_id
        if team_name == match.team_a.name
          match.team_a.players.each do |player|
            if player.state == 'available'
              to_return << {id => player.ci, name => player.name}
            end
          end
        elsif team_name == match.team_b.name
          match.team_b.players.each do |player|
            if player.state == 'available'
              to_return << {id => player.ci, name => player.name}
            end
          end
        end
        to_return
      end
    end
  end

  def add_match_action(match_id, team_name, player_id, action)
    @championship.matches.each do |match|
      if match.id == match_id
        selected_match = match
        if match.team_a.name == team_name
          selected_team = match.team_a
          a_or_b = 'a'
        elsif match.team_b.name == team_name
          selected_team = match.team_b
          a_or_b = 'b'
        end
      end
    end
    selected_team.players.each do |player|
      if player.ci == player_id
        selected_player = player
      end
    end

    case action
    when :shoot
      selected_player.shoots += 1
      selected_player.percent_effectiveness = (selected_player.goals / selected_player.shoots) * 100
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha disparado al arco"
    when :goal
      selected_player.goals += 1
      selected_player.percent_effectiveness = (selected_player.goals / selected_player.shoots) * 100
      selected_match.news<< "#{selected_player.name} (#{selected_team.name}) ha marcado un gol"
      if a_or_b == 'a'
        match.team_a_goals += 1
      elsif a_or_b == 'b'
        match.team_b_goals += 1
      end
      selected_team.goals +=1
    when :small_box_goal
      selected_player.small_box_goals += 1
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha marcado un gol en el area pequeña"
      if a_or_b == 'a'
        match.team_a_goals += 1
      elsif a_or_b == 'b'
        match.team_b_goals += 1
      end
      selected_team.goals +=1
    when :good_pass
      selected_player.good_passes += 1
      selected_player.percentage_passes = (selected_player.good_passes / selected_player.good_passes+selected_player.wrong_passes)*100
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha dado un pase correcto"
    when :wrong_pass
      selected_player.wrong_passes += 1
      selected_player.percentage_passes = (selected_player.good_passes / selected_player.good_passes+selected_player.wrong_passes)*100
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha dado un pase pero hay fallado"
    when :intercepted_pass
      selected_player.interceptions += 1
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha interceptado un pase"
    when :yellow_card
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha recibido una tarjeta amarilla"
      selected_player.yellow_cards += 1
      if selected_player.yellow_cards >= 2
        selected_player.state = 'unavailable'
        selected_player.yellow_cards = 0
        selected_match.news << "#{selected_player.name} (#{selected_team.name}) es expulsado por doble tarjeta amarila"
      end
    when :red_card
      selected_player.state = 'unavailable'
      selected_match.news << "#{selected_player.name} (#{selected_team.name}) ha recibido una tarjeta roja, es expulsado"
    end
  end

  def get_table_data
    exit = false
    contador = 0
    to_return = []
    re_ordered_teams = []
    ordered_teams = @championship.teams.sort {|a,b| a.puntos <=> b.puntos}
    ordered_teams.each do |team|
      until contador == ordered_teams.size
        if team != ordered_teams[contador]
          if team.points == ordered_teams[contador].points && team.goals < ordered_teams[contador].goals
            ordered_teams[contador] = team
            ordered_teams[ordered_teams.index(team)] = ordered_teams[contador]
          end
        end
        contador +=1
      end
      contador = 0
    end
    ordered_teams.each do |team|
      to_return << {team_name => team.name, played_matches => team.pj, won_matches => team.pg, drawn_matches => team.pe, lost_matches => team.pp, goals_difference => team.goals, points => team.points}
    end
    to_return
  end

  def get_news_data
    to_return = []
    @championship.matches.each do |match|
      match.news.each do |news|
        to_return << news
      end
    end
    to_return
  end
end
