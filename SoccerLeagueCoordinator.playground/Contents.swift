import UIKit

// Players data model: Array containing dictionary of players
let players: [Int:[String : Any]] = [
    0 : ["name" : "Joe Smith",
         "height" : 42,
         "playedBefore" : true,
         "guardianFullName" : "Jim and Jan Smith"],
    1 : ["name" : "Jill Tanner",
         "height": 36,
         "playedBefore":true,
         "guardianFullName": "Clara Tanner"],
    2 : ["name":"Bill Bon",
         "height": 43,
         "playedBefore":true,
         "guardianFullName": "Sara and Jenny Bon"],
    3 : ["name":"Eva Gordon",
         "height":45,
         "playedBefore":false,
         "guardianFullName": "Wendy and Mike Gordon"],
    4 : ["name":"Matt Gill",
         "height":40,
         "playedBefore":false,
         "guardianFullName": "Charles and Sylvia Gill"],
    5 : ["name":"Kimmy Stein",
         "height": 41,
         "playedBefore": false,
         "guardianFullName": "Bill and Hillary Stein"],
    6 : ["name":"Bill and Hillary Stein",
         "height": 45,
         "playedBefore":false,
         "guardianFullName": "Jeff Adams"],
    7 : ["name":"Karl Saygan",
         "height": 42,
         "playedBefore":true,
         "guardianFullName": "Heather Bledsoe"],
   8 : ["name":"Suzane Greenberg",
         "height": 44,
         "playedBefore":true,
         "guardianFullName": "Henrietta Dumas"],
   9 : ["name":"Sal Dali",
        "height": 41,
        "playedBefore":false,
        "guardianFullName": "Gala Dali"],
   10 : ["name":"Joe Kavalier",
        "height":39,
        "playedBefore":false,
        "guardianFullName": "Sam and Elaine Kavalier"],
   11 : ["name":"Ben Finkelstein",
        "height":44,
        "playedBefore":false,
        "guardianFullName": "Aaron and Jill Finkelstein"],
   12 : ["name":"Diego Soto",
        "height": 41,
        "playedBefore":true,
        "guardianFullName": "Robin and Sarika Soto"],
   13 : ["name":"Chloe Alaska",
        "height": 47,
        "playedBefore": false,
        "guardianFullName": "David and Jamie Alaska"],
   14 : ["name":"Arnold Willis",
        "height": 43,
        "playedBefore": false,
        "guardianFullName": "Claire Willis"],
   15 : ["name":"Phillip Helm",
        "height": 44,
        "playedBefore":true,
        "guardianFullName": "Thomas Helm and Eva Jones"],
   16 : ["name":"Les Clay",
        "height": 42,
        "playedBefore":true,
        "guardianFullName": "Wynonna Brown"],
   17 : ["name":"Herschel Krustofski",
        "height": 45,
        "playedBefore":true,
        "guardianFullName": "Hyman and Rachel Krustofski"]
]

// Teams Data Model
let teams: [String] = ["teamSharks", "teamDragons", "teamRaptors"]
let totalNumberOfTeams: Int = teams.count // Get total number of teams

// stores players for each team
var Sharks = [[String: Any]]()
var Dragons = [[String: Any]]()
var Raptors = [[String: Any]]()

// Arrays to classify if a player has experienced or not
var playersWithExperience: [Int] = []
var playersWithoutExperience: [Int] = []

// Keeps track of chosen numbers to avoid duplicates
// From Apple's documentation
// https://developer.apple.com/documentation/swift/set
var alreadyChoosenTeams: Set<Int> = []

var letters : [String] = []

/**
 Separates players with experience or not from data model and appends them to the global variables
 playersWithExperience and playersWithoutExperience
 
 - Parameter players: Array:Dictionary with list of players
 
 - Returns: nil
*/
func classifyExperienceOflayers(from players: [Int:[String : Any]] ) -> () {
    for (index, player) in players {
        if player["playedBefore"] as! Bool == true {
            playersWithExperience.append(index)
        } else {
            playersWithoutExperience.append(index)
        }
    }
}

/**
 Ramdomly chooses a team for a player
 https://developer.apple.com/documentation/swift/set
 
 - Parameter: nil
 
 - Return: Team name or "n/a"
 */
func chooseRandomTeam() -> String {
    
    // resets the dataset
    if alreadyChoosenTeams.count == totalNumberOfTeams {
        alreadyChoosenTeams.removeAll()
    }
    
    // Random choose a team
    // https://developer.apple.com/documentation/swift/int/2995648-random
    let index = Int.random(in: 1 ... totalNumberOfTeams)
    
    // if the chosen team is already in the data set, return n/a
    if alreadyChoosenTeams.contains(index) {
        return "n/a"
    }
    
    // insert into dataset to avoid selecting the same team
    alreadyChoosenTeams.insert(index)
    return teams[index - 1]
}


/**
 Adds player to a team
 
 - Parameter team: The name of the team
 - Parameter player: The Id of the player within the players data model
 
 - Return: nil
 */
func assingPlayers(to team:String, for player: Int) -> () {

    guard let player = players[player] else {
        return
    }

    switch team {
    case "teamSharks":
        Sharks.append(player)
    case "teamDragons":
        Dragons.append(player)
    default:
        Raptors.append(player)
    }
}

/**
 Assings an experiences and non experience player to the same team
 for all teams to have the same level of players
 
 -Parameter: nil
 
 - Return: nil
*/
func assingPlayersToTeams() -> () {
    let totalNumberOfPlayers: Int = players.count

    var counter = 1

    // loop through each player
    while counter <= totalNumberOfPlayers {
        
        var pickPlayer = 0
        
        // select randomly a team
        var teamName = "n/a"
        // if no team is select, we force to select one that has not previously picked
        while teamName == "n/a" {
            teamName = chooseRandomTeam()
        }
        
        // pick an experience player
        if !playersWithExperience.isEmpty {
            
            pickPlayer = Int.random(in: 0 ... playersWithExperience.count - 1)
            
            // assign an experienced player to the ramdom selected team
            assingPlayers(to: teamName, for: playersWithExperience[pickPlayer])
            
            //remove form the set
            playersWithExperience.remove(at: pickPlayer)
        }


        // pick a non experienced player
        if !playersWithoutExperience.isEmpty {
            
            pickPlayer = Int.random(in: 0 ... playersWithoutExperience.count - 1)
            
            // assign a NON experienced player to the same random team
            assingPlayers(to: teamName, for: playersWithoutExperience[pickPlayer])
            
            //remove form the set
            playersWithoutExperience.remove(at: pickPlayer)
        }
        
        counter += 1
    }
}

/**
 Send welcome letter to players within a team
 
 - Parameter team: Teams' data
 - Parameter name: Name of the team
 
 - Return: nil
*/
func setWelcomeLetters(to team:[[String:Any]], with name:String) -> () {
    
    let practiceDate = setPracticeDate(for: name)
    let schedule = allTeamsSchedule()
    
    for (index, _) in team.enumerated() {
        let playerName = team[index]["name"] as! String
        let guardian = team[index]["guardianFullName"] as! String
        
        
        let letterStringLiteral = """
        Dear \(playerName),
        We are pleased to inform you that you have made it to the \(name)'s Team
        Be ready to your first day of practice on \(practiceDate)
        
        \(guardian), as a guardian, please don't forget to bring snacks.
        
        Looking forward to see you all in the fields.
        
        Here is the schedule for all the teams:
        \(schedule)
        
        Thanks
        
        Coach Robin
        
        """
        //append letter to letters
        letters.append(letterStringLiteral)
    }
}

/**
 gets the schedule for all teams
 
 - Parameter: nil
 
 - Return: String with the schedule of all the teams
*/
func allTeamsSchedule() -> String {
    
    var teamsPractideDates = ""
    
    for team in teams {
        switch team {
        case "teamSharks":
            teamsPractideDates = teamsPractideDates + "\n\nSharks - " + setPracticeDate(for: "Sharks")
        case "teamDragons":
            teamsPractideDates = teamsPractideDates + "\n\nDragons - " + setPracticeDate(for: "Dragons")
        case "teamRaptors":
            teamsPractideDates = teamsPractideDates + "\n\nRaptors - " + setPracticeDate(for: "Raptors")
        default:
            teamsPractideDates += ""
        }
    }
    
    return teamsPractideDates
}

/**
 sets practice time
 
 - Parameter team: The name of the team
 
 - Return: Date formated as a string
*/
func setPracticeDate(for team:String) -> String {
    
    var date: Date? = nil
    
    // Format date
    // https://developer.apple.com/documentation/foundation/dateformatter
    // https://stackoverflow.com/questions/35700281/date-format-in-swift
    // BatyrCan - https://stackoverflow.com/users/7357675/batyrcan
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")  // US English Locale (en_US)
    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
    
    switch team {
    case "Sharks":
        date = dateFormatter.date(from: "March 17, 2019 1:00 PM")
    case "Dragons":
        date = dateFormatter.date(from: "March 17, 2019 3:00 PM")
    default:
        date = dateFormatter.date(from: "March 18, 2019 1:00 PM")
    }
   
    dateFormatter.dateFormat = "MMM d, ha"
    let praticeDate = dateFormatter.string(from: date!)
    
    return praticeDate
}

// Classify the players based on experience (if they played before or not)
classifyExperienceOflayers(from: players)

// Assign players to a random team
assingPlayersToTeams()

// send welcome letter to Sharks
setWelcomeLetters(to: Sharks, with: "Sharks")

// send welcome letter to Dragons
setWelcomeLetters(to: Dragons, with: "Dragons")

// send welcome letter to Raptors
setWelcomeLetters(to: Raptors, with: "Raptors")

for (index, value) in letters.enumerated() {
    print("\(index) => \(value)")
}
