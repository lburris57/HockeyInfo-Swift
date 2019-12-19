//
//  RosterPlayers.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/1/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation

struct RosterPlayers: Decodable
{
    var lastUpdatedOn: String
    var playerInfoList: [PlayerInfo]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case playerInfoList = "players"
    }
}

struct PlayerInfo: Decodable
{
    var player: PlayerData
    var currentTeamInfo: CurrentTeamData?
    
    private enum CodingKeys : String, CodingKey
    {
        case player = "player"
        case currentTeamInfo = "teamAsOfDate"
    }
}

struct CurrentTeamData: Decodable
{
    var id: Int = 0
    var abbreviation: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case abbreviation = "abbreviation"
    }
}

struct PlayerData: Decodable
{
    var id: Int = 0
    var firstName: String
    var lastName: String
    var position: String?
    var jerseyNumber: Int?
    var currentRosterStatus: String?
    var height: String?
    var weight: Int?
    var birthDate: String?
    var age: Int?
    var birthCity: String?
    var birthCountry: String?
    var rookie: Bool?
    var officialImageSource: URL?
    var currentInjuryInfo: CurrentInjuryData?
    var handednessInfo: HandednessData?
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case position = "primaryPosition"
        case jerseyNumber = "jerseyNumber"
        case currentRosterStatus = "currentRosterStatus"
        case height = "height"
        case weight = "weight"
        case birthDate = "birthDate"
        case age = "age"
        case birthCity = "birthCity"
        case birthCountry = "birthCountry"
        case rookie = "rookie"
        case officialImageSource = "officialImageSrc"
        case currentInjuryInfo = "currentInjury"
        case handednessInfo = "handedness"
    }
}

struct CurrentInjuryData: Decodable
{
    var description: String
    var playingProbability: String
    
    private enum CodingKeys : String, CodingKey
    {
        case description = "description"
        case playingProbability = "playingProbability"
    }
}

struct HandednessData: Decodable
{
    var shoots: String?
    
    private enum CodingKeys : String, CodingKey
    {
        case shoots = "shoots"
    }
}

struct PenaltyData: Decodable
{
    var penalties: Int?
    var penaltyMinutes: Int?
    
    private enum CodingKeys : String, CodingKey
    {
        case penalties = "penalties"
        case penaltyMinutes = "penaltyMinutes"
    }
}

struct SkatingData: Decodable
{
    var plusMinus: Int?
    var shots: Int?
    var shotPercentage: Double?
    var blockedShots: Int?
    var hits: Int?
    var faceoffs: Int?
    var faceoffWins: Int?
    var faceoffLosses: Int?
    var faceoffPercent: Double?
    
    private enum CodingKeys : String, CodingKey
    {
        case plusMinus = "plusMinus"
        case shots = "shots"
        case shotPercentage = "shotPercentage"
        case blockedShots = "blockedShots"
        case hits = "hits"
        case faceoffs = "faceoffs"
        case faceoffWins = "faceoffWins"
        case faceoffLosses = "faceoffLosses"
        case faceoffPercent = "faceoffPercent"
    }
}

struct ScoringData: Decodable
{
    var goals: Int?
    var assists: Int?
    var points: Int?
    var hatTricks: Int?
    var powerplayGoals: Int?
    var powerplayAssists: Int?
    var powerplayPoints: Int?
    var shorthandedGoals: Int?
    var shorthandedAssists: Int?
    var shorthandedPoints: Int?
    var gameWinningGoals: Int?
    var gameTyingGoals: Int?
    
    private enum CodingKeys : String, CodingKey
    {
        case goals = "goals"
        case assists = "assists"
        case points = "points"
        case hatTricks = "hatTricks"
        case powerplayGoals = "powerplayGoals"
        case powerplayAssists = "powerplayAssists"
        case powerplayPoints = "powerplayPoints"
        case shorthandedGoals = "shorthandedGoals"
        case shorthandedAssists = "shorthandedAssists"
        case shorthandedPoints = "shorthandedPoints"
        case gameWinningGoals = "gameWinningGoals"
        case gameTyingGoals = "gameTyingGoals"
    }
}

struct PlayerStats: Decodable
{
    var lastUpdatedOn: String?
    var playerStatsTotals: [PlayerStatsTotal]?
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case playerStatsTotals = "playerStatsTotals"
    }
}

struct PlayerStatsTotal: Decodable
{
    var player: PlayerStatId?
    var playerStats: PlayerStatData?
    
    private enum CodingKeys : String, CodingKey
    {
        case player = "player"
        case playerStats = "stats"
    }
}

struct PlayerStatData: Decodable
{
    var gamesPlayed: Int?
    var scoringData: ScoringData?
    var skatingData: SkatingData?
    var goaltendingData: GoaltendingData?
    var penaltyData: PenaltyData?
    
    private enum CodingKeys : String, CodingKey
    {
        case gamesPlayed = "gamesPlayed"
        case scoringData = "scoring"
        case skatingData = "skating"
        case goaltendingData = "goaltending"
        case penaltyData = "penalties"
    }
}

struct PlayerStatId: Decodable
{
    var id: Int?
    var firstName: String?
    var lastName: String?
    var currentTeam: CurrentTeamData?
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case currentTeam = "currentTeam"
    }
}

struct GoaltendingData: Decodable
{
    var wins: Int?
    var losses: Int?
    var overtimeWins: Int?
    var overtimeLosses: Int?
    var goalsAgainst: Int?
    var shotsAgainst: Int?
    var saves: Int?
    var goalsAgainstAverage: Double?
    var savePercentage: Double?
    var shutouts: Int?
    var gamesStarted: Int?
    var creditForGame: Int?
    var minutesPlayed: Int?
    
    private enum CodingKeys : String, CodingKey
    {
        case wins = "wins"
        case losses = "losses"
        case overtimeWins = "overtimeWins"
        case overtimeLosses = "overtimeLosses"
        case goalsAgainst = "goalsAgainst"
        case shotsAgainst = "shotsAgainst"
        case saves = "saves"
        case goalsAgainstAverage = "goalsAgainstAverage"
        case savePercentage = "savePercentage"
        case shutouts = "shutouts"
        case gamesStarted = "gamesStarted"
        case creditForGame = "creditForGame"
        case minutesPlayed = "minutesPlayed"
    }
}

struct PlayerInjuries: Decodable
{
    var lastUpdatedOn: String
    var playerInjuryInfoList: [PlayerInjuryInfo]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case playerInjuryInfoList = "players"
    }
}

struct PlayerInjuryInfo: Decodable
{
    var id: Int = 0
    var firstName: String
    var lastName: String
    var position: String?
    var jerseyNumber: Int?
    var currentTeamInfo: CurrentTeamData?
    var currentInjuryInfo: CurrentInjuryData?
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case position = "primaryPosition"
        case jerseyNumber = "jerseyNumber"
        case currentTeamInfo = "currentTeam"
        case currentInjuryInfo = "currentInjury"
    }
}
