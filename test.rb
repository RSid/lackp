
require 'CSV'

=begin
@all_data=[]

@teams=[]


CSV.foreach('sroster.csv', :headers => true) do |row|
  first=row["first_name"]
  last=row["last_name"]
  position=row["position"]
  team=row["team"]

  @all_data.push( {:Team => team, :First_Name => first, :Last_Name => last, :Position => position} )
end

@all_data.each do |hashes|
  @teams.push(hashes[:Team])

end

print @teams.uniq
=end

def get_data(file_name)
  @all_data=[]

  CSV.foreach(file_name, :headers => true) do |row|
    first=row["first_name"]
    last=row["last_name"]
    position=(row["position"]).tr(" ","_")
    team=(row["team"]).tr(" ","_")

    @all_data.push( {:Team => team, :First_Name => first, :Last_Name => last, :Position => position} )
  end

  @all_data
end

#gets an array of unique team names out of array of hashes
def make_team_array(file_name)

  array_of_hashes=get_data(file_name)

  @teams=[]
  array_of_hashes.each do |hashes|
    @teams.push(hashes[:Team])
  end
  @teams.uniq
end

def make_roster_array(file_name, team_name)

  array_of_hashes=get_data(file_name)
  @players=[]

  array_of_hashes.each do |hashes|

    if hashes[:Team]==team_name
      @players.push(hashes[:First_Name] + " " + hashes[:Last_Name])

    end
  end
  @players
end

def make_positions_array(file_name)

  array_of_hashes=get_data(file_name)
  @positions=[]

  array_of_hashes.each do |hashes|
    @positions.push(hashes[:Position])
  end
  @positions.uniq

end

def make_position_player_array(file_name, position_name)
  array_of_hashes=get_data(file_name)
  @position_players=[]

  array_of_hashes.each do |hashes|

    if hashes[:Position]==position_name
      @position_players.push(hashes[:First_Name] + " " + hashes[:Last_Name])

    end
  end
  @position_players
end


#print make_roster_array('sroster.csv',"Flinestone Fire")

#print get_data('sroster.csv')

#print make_positions_array('sroster.csv')

print make_position_player_array('sroster.csv', '1st_Base')
