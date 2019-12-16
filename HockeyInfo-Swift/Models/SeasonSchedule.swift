//
//  SeasonSchedule.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/1/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation

struct SeasonSchedule: Decodable
{
    var lastUpdatedOn: String
    var gameList: [ScheduledGame]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case gameList = "games"
    }
}

struct ScheduledGame: Decodable
{
    var scheduleInfo: ScheduleInfo
    var scoreInfo: ScoreInfo
    
    private enum CodingKeys : String, CodingKey
    {
        case scheduleInfo = "schedule"
        case scoreInfo = "score"
    }
}

struct ScoreInfo: Decodable
{
    var currentPeriod : Int?
    var currentPeriodSecondsRemaining: Int?
    var awayScoreTotal: Int?
    var awayShotsTotal: Int?
    var homeScoreTotal: Int?
    var homeShotsTotal: Int?
    var periodList: [PeriodInfo]?
    
    private enum CodingKeys : String, CodingKey
    {
        case currentPeriod = "currentPeriod"
        case currentPeriodSecondsRemaining = "currentPeriodSecondsRemaining"
        case awayScoreTotal = "awayScoreTotal"
        case awayShotsTotal = "awayShotsTotal"
        case homeScoreTotal = "homeScoreTotal"
        case homeShotsTotal = "homeShotsTotal"
        case periodList = "periods"
    }
}

struct PeriodInfo: Decodable
{
    var periodNumber: Int = 0
    var awayScore: Int = 0
    var awayShots: Int = 0
    var homeScore: Int = 0
    var homeShots: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case periodNumber = "periodNumber"
        case awayScore = "awayScore"
        case awayShots = "awayShots"
        case homeScore = "homeScore"
        case homeShots = "homeShots"
    }
}

struct ScheduleInfo: Decodable
{
    var id: Int = 0
    var startTime: String
    var venueAllegiance: String
    var scheduleStatus: String
    var playedStatus: String
    var awayTeamInfo: TeamData
    var homeTeamInfo: TeamData
    var venueInfo: VenueData
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case venueAllegiance = "venueAllegiance"
        case scheduleStatus = "scheduleStatus"
        case playedStatus = "playedStatus"
        case awayTeamInfo = "awayTeam"
        case homeTeamInfo = "homeTeam"
        case venueInfo = "venue"
    }
}

struct VenueData: Decodable
{
    var id: Int = 0
    var name: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case name = "name"
    }
}
