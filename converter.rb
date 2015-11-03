class Converter

  def self.player_converter(player)
    case player.position
    when 'Arquero'
      return {:ci => player.ci, :name => player.name, :birthdate => player.birthdate, :position => player.position, :goals => player.goals, :small_box_goals => player.small_box_goals}
    when 'Delantero'
      return {:ci => player.ci, :name => player.name, :birthdate => player.birthdate, :position => player.position, :goals => player.goals, :percent_effectiveness => player.percent_effectiveness}
    when 'Defensa'
      return {:ci => player.ci, :name => player.name, :birthdate => player.birthdate, :position => player.position, :interceptions => player.interceptions}
    when 'Volante'
      return {:ci => player.ci, :name => player.name, :birthdate => player.birthdate, :position => player.position, :goals => player.goals, :percentage_passes => player.percentage_passes}
    end
  end

  def self.team_converter(team)
    {:name => team.name, :players => team.players}
  end

  
end

class Identifier
  def self.identify(selector, list)
    list.each do |identified|
      if identified.class.superclass == Player
        if identified.ci == selector
          return identified
        end
      elsif identified.class == Team
        if identified.name == selector
          return identified
        end
      else
        if identified.id == selector
          return identified
        end
      end
    end
  end
  nil
end
