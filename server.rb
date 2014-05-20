require 'sinatra'
require 'uri'
require 'CSV'
require 'pry'

#Gets all data from CSV file into array of hashes
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
      @players.push(hashes[:First_Name] + " " + hashes[:Last_Name] + ", " + hashes[:Position].tr("_"," "))

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
      @position_players.push(hashes[:First_Name] + " " + hashes[:Last_Name] + ", " + hashes[:Team].tr("_"," "))

    end
  end
  @position_players
end

get '/' do
  @teams=make_team_array('sroster.csv')
  @positions=make_positions_array('sroster.csv')
  erb :show
end


get '/team_rosters/:team_name' do
  #will want to somehow make this list be dictated by above
  #and have links created from @teams
  @team_rosters = params[:team_name]

  @players=make_roster_array('sroster.csv',@team_rosters)

  erb :team
end

get '/positions/:position_players' do
  #will want to somehow make this list be dictated by above
  #and have links created from @teams
  @position = params[:position_players]

  @position_players=make_position_player_array('sroster.csv', @position)

  erb :position
end
