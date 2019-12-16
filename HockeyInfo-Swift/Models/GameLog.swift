//
//  GameLog.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/28/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation

struct GameLog: Decodable
{
    var lastUpdatedOn: String
    var gameLogDataList: [GameLogData]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case gameLogDataList = "gamelogs"
    }
}

struct GameLogData: Decodable
{
    var game: GameData
    var team: TeamData
    var stats: StatsData
    
    private enum CodingKeys : String, CodingKey
    {
        case game = "game"
        case team = "team"
        case stats = "stats"
    }
}

struct TeamData: Decodable
{
    var id: Int = 0
    var abbreviation  : String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case abbreviation = "abbreviation"
    }
}

struct GameData: Decodable
{
    var id: Int
    var startTime: String
    var awayTeamAbbreviation: String
    var homeTeamAbbreviation: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case awayTeamAbbreviation = "awayTeamAbbreviation"
        case homeTeamAbbreviation = "homeTeamAbbreviation"
    }
}
    
struct StatsData: Decodable
{
    var standings: StandingsData
    var faceoffs: FaceoffData
    var powerplay: PowerplayData
    var miscellaneous: MiscellaneousData
    
    private enum CodingKeys : String, CodingKey
    {
        case standings = "standings"
        case faceoffs = "faceoffs"
        case powerplay = "powerplay"
        case miscellaneous = "miscellaneous"
    }
}
    
struct StandingsData: Decodable
{
    var wins: Int = 0
    var losses: Int = 0
    var overtimeWins: Int = 0
    var overtimeLosses: Int = 0
    var points: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case wins = "wins"
        case losses = "losses"
        case overtimeWins = "overtimeWins"
        case overtimeLosses = "overtimeLosses"
        case points = "points"
    }
}

struct FaceoffData: Decodable
{
    var faceoffWins: Int = 0
    var faceoffLosses: Int = 0
    var faceoffPercent: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case faceoffWins = "faceoffWins"
        case faceoffLosses = "faceoffLosses"
        case faceoffPercent = "faceoffPercent"
    }
}

struct PowerplayData: Decodable
{
    var powerplays: Int = 0
    var powerplayGoals: Int = 0
    var powerplayPercent: Double = 0.0
    var penaltyKills: Int = 0
    var penaltyKillGoalsAllowed: Int = 0
    var penaltyKillPercent: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case powerplays = "powerplays"
        case powerplayGoals = "powerplayGoals"
        case powerplayPercent = "powerplayPercent"
        case penaltyKills = "penaltyKills"
        case penaltyKillGoalsAllowed = "penaltyKillGoalsAllowed"
        case penaltyKillPercent = "penaltyKillPercent"
    }
}

struct MiscellaneousData: Decodable
{
    var goalsFor: Int = 0
    var goalsAgainst: Int = 0
    var shots: Int = 0
    var penalties: Int = 0
    var penaltyMinutes: Int = 0
    var hits: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case goalsFor = "goalsFor"
        case goalsAgainst = "goalsAgainst"
        case shots = "shots"
        case penalties = "penalties"
        case penaltyMinutes = "penaltyMinutes"
        case hits = "hits"
    }
}

struct GameLogReferences: Decodable
{
    var gameReferences: [GameReference]
    
    private enum CodingKeys : String, CodingKey
    {
        case gameReferences = "gameReferences"
    }
}

struct GameReference: Decodable
{
    var id: Int
    var startTime: String
    var awayTeam: TeamData
    var homeTeam: TeamData
    var playedStatus: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case awayTeam = "awayTeam"
        case homeTeam = "homeTeam"
        case playedStatus = "playedStatus"
    }
}



