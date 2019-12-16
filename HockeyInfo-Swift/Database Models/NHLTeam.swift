//
//  NHLTeam.swift
//  Hockey Info
//
//  Created by Larry Burris on 11/20/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NHLTeam : Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var abbreviation : String = ""
    @objc dynamic var city : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var division : String = ""
    @objc dynamic var conference : String = ""
    @objc dynamic var dateCreated: String = ""
    @objc dynamic var season: String = Constants.EMPTY_STRING
    @objc dynamic var seasonType = Constants.EMPTY_STRING
    
    var players = List<NHLPlayer>()
    var standings = List<TeamStandings>()
    var statistics = List<TeamStatistics>()
    var schedules = List<NHLSchedule>()
    var playerInjuries = List<NHLPlayerInjury>()
    var gameLogs = List<NHLGameLog>()
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
