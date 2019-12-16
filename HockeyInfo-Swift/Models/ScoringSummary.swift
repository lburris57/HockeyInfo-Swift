//
//  ScoringSummary.swift
//  Hockey Info
//
//  Created by Larry Burris on 1/20/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct ScoringSummary: Decodable
{
    var lastUpdatedOn: String
    var game: GameReference
    var scoringInfo: ScoringInfo
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case game = "game"
        case scoringInfo = "scoring"
    }
}

struct ScoringInfo: Decodable
{
    var homeScoreTotal: Int
    var awayScoreTotal: Int
    var periodList: [PeriodScoringData]
    
    private enum CodingKeys : String, CodingKey
    {
        case homeScoreTotal = "homeScoreTotal"
        case awayScoreTotal = "awayScoreTotal"
        case periodList = "periods"
    }
}

struct PeriodScoringData: Decodable
{
    var periodNumber: Int
    var homeScore: Int
    var awayScore: Int
    var scoringPlays: [ScoringPlay]
    
    private enum CodingKeys : String, CodingKey
    {
        case periodNumber = "periodNumber"
        case homeScore = "homeScore"
        case awayScore = "awayScore"
        case scoringPlays = "scoringPlays"
    }
}

struct ScoringPlay: Decodable
{
    var team: TeamData
    var periodSecondsElapsed: Int
    var playDescription: String
    
    private enum CodingKeys : String, CodingKey
    {
        case team = "team"
        case periodSecondsElapsed = "periodSecondsElapsed"
        case playDescription = "playDescription"
    }
}
