//
//  NHLStandings.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/1/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation

struct NHLStandings: Decodable
{
    var lastUpdatedOn: String
    var references: StandingsReferenceData
    var teamList: [TeamStandingsData]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case references = "references"
        case teamList = "teams"
    }
}

struct StandingsCategory: Decodable
{
    var category: String
    var fullName: String
    var description: String
    var abbreviation: String
    var type: String
    
    private enum CodingKeys : String, CodingKey
    {
        case category = "category"
        case fullName = "fullName"
        case description = "description"
        case abbreviation = "abbreviation"
        case type = "type"
    }
}

struct StandingsReferenceData: Decodable
{
    var standingsCategories: [StandingsCategory]
    
    private enum CodingKeys : String, CodingKey
    {
        case standingsCategories = "teamStatReferences"
    }
}

struct TeamStandingsData: Decodable
{
    var teamInformation: TeamInformation
    var teamStats: TeamStats
    var overallRankInfo: OverallRankData
    var conferenceRankInfo: ConferenceRankData
    var divisionRankInfo: DivisionRankData
    var playoffRankInfo: PlayoffRankData
    
    private enum CodingKeys : String, CodingKey
    {
        case teamInformation = "team"
        case teamStats = "stats"
        case overallRankInfo = "overallRank"
        case conferenceRankInfo = "conferenceRank"
        case divisionRankInfo = "divisionRank"
        case playoffRankInfo = "playoffRank"
    }
}

struct TeamInformation: Decodable
{
    var id: Int = 0
    var city: String
    var name: String
    var abbreviation: String
    var venueInfo: VenueData
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case city = "city"
        case name = "name"
        case abbreviation = "abbreviation"
        case venueInfo = "homeVenue"
    }
}

struct PlayoffRankData: Decodable
{
    var conferenceName: String
    var divisionName: String?
    var appliesTo: String
    var rank: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case conferenceName = "conferenceName"
        case divisionName = "divisionName"
        case appliesTo = "appliesTo"
        case rank = "rank"
    }
}

struct TeamStats: Decodable
{
    var gamesPlayed: Int
    var standingsInfo: StandingsData
    var faceoffInfo: FaceoffData
    var powerplayInfo: PowerplayData
    var miscellaneousInfo: MiscellaneousData
    
    private enum CodingKeys : String, CodingKey
    {
        case gamesPlayed = "gamesPlayed"
        case standingsInfo = "standings"
        case faceoffInfo = "faceoffs"
        case powerplayInfo = "powerplay"
        case miscellaneousInfo = "miscellaneous"
    }
}

struct OverallRankData: Decodable
{
    var rank: Int = 0
    var gamesBack: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case rank = "rank"
        case gamesBack = "gamesBack"
    }
}

struct ConferenceRankData: Decodable
{
    var conferenceName: String
    var rank: Int = 0
    var gamesBack: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case conferenceName = "conferenceName"
        case rank = "rank"
        case gamesBack = "gamesBack"
    }
}

struct DivisionRankData: Decodable
{
    var divisionName: String
    var rank: Int = 0
    var gamesBack: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case divisionName = "divisionName"
        case rank = "rank"
        case gamesBack = "gamesBack"
    }
}

