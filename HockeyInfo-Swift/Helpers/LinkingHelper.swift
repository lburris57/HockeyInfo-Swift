//
//  LinkingHelper.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit
import RealmSwift

struct LinkingHelper
{
    func linkPlayersToStatistics(with playerList: [NHLPlayer], playerStatisticsList: [PlayerStatistics]) -> [NHLPlayer]
    {
        let realm = try! Realm()
        
        var updatedPlayerList = [NHLPlayer]()
        
        var playerDictionary = [Int:NHLPlayer]()
        
        //  Create a dictionary with id as the key
        for player in playerList
        {
            playerDictionary[player.id] = player
        }
        
        for playerStatistics in playerStatisticsList
        {
            let playerId = playerStatistics.id
            
            if let player = playerDictionary[playerId]
            {
                playerStatistics.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                
                try! realm.write
                {
                    //  Save it to realm
                    realm.create(PlayerStatistics.self, value: playerStatistics, update: .modified)
                    
                    //  Get the playerStatistics reference from the database
                    if let realmPlayerStatistics = realm.object(ofType: PlayerStatistics.self, forPrimaryKey: playerId)
                    {
                        player.playerStatisticsList.append(realmPlayerStatistics)
                    
                        updatedPlayerList.append(player)
                    }
                }
            }
        }
        
        return updatedPlayerList
    }
    
    func linkPlayersToInjuries(with playerList: [NHLPlayer], injuryList: [NHLPlayerInjury]) -> [NHLPlayer]
    {
        let realm = try! Realm()
        
        var updatedPlayerList = [NHLPlayer]()
        
        var playerDictionary = [Int:NHLPlayer]()
        
        //  Create a dictionary with id as the key
        for player in playerList
        {
            playerDictionary[player.id] = player
        }
        
        try! realm.write
        {
            //  Delete any records in the injury table
            realm.delete(realm.objects(NHLPlayerInjury.self))
            
            for playerInjury in injuryList
            {
                let playerId = playerInjury.id
                
                if let player = playerDictionary[playerId]
                {
                    playerInjury.dateCreated = TimeAndDateUtils.getCurrentDateAsString()

                    //  Save it to realm
                    realm.create(NHLPlayerInjury.self, value: playerInjury, update: .modified)

                    //  Get the playerInjury reference from the database and save it to the player
                    if let realmPlayerInjury = realm.object(ofType: NHLPlayerInjury.self, forPrimaryKey: playerId)
                    {
                        player.playerInjuries.append(realmPlayerInjury)
                        
                        updatedPlayerList.append(player)
                    }
                }
            }
        }
        
        return updatedPlayerList
    }
}
