//
//  NetworkManager.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit

protocol NetworkManagerDelegate
{
    func didPerformNetworkCall<T>(_ obj: T)
    func didFailWithError(error: Error)
}

struct NetworkManager
{
    let decoder = JSONDecoder()
    
    let session = URLSession(configuration: .default)
    
    let modelConverter = ConvertNetworkModelToDatabaseModel()
    let databaseManager = DatabaseManager()
    let linkingHelper = LinkingHelper()
    
    var delegate: NetworkManagerDelegate?
    
    func fetchSeasonSchedule()
    {
        let urlString = ""
        
        let task = session.dataTask(with: createRequest(urlString))
        {
            (data, response, error) in
            
            if error != nil
            {
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                do
                {
                    let seasonSchedule = try self.decoder.decode(SeasonSchedule.self, from: data)
                    
                    let nhlScheduleList = self.modelConverter.convertSeasonScheduleToNHLScheduleList(seasonSchedule)
                    
                    //  Save the data to the database
                    self.databaseManager.saveFullSeasonScheduleGameData(nhlScheduleList)
                    
                    self.delegate?.didPerformNetworkCall(nhlScheduleList)
                }
                catch
                {
                    print(error.localizedDescription)
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
        task.resume()
    }
    
    //  This method retrieves the roster players from the sports web service, converts the results into an nhlPlayerList,
    //  calls the method to retrieve all player stats sending the nhlPlayerList which appends the player stats data and
    //  calls the method to retrieve all player injuries which appends the injury data to the players, saves the player list
    //  to the database in a background thread and calls the delegate's didPerformNetworkCall() method.
    func fetchRosterPlayers()
    {
        let urlString = ""
        
        let task = session.dataTask(with: createRequest(urlString))
        {
            (data, response, error) in
            
            if error != nil
            {
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                do
                {
                    let rosterPlayers = try self.decoder.decode(RosterPlayers.self, from: data)
                    
                    let nhlPlayerList = self.modelConverter.convertRosterPlayersToNHLPlayerList(rosterPlayers)
                    
                    self.fetchPlayerStatistics(nhlPlayerList)
                }
                catch
                {
                    print(error.localizedDescription)
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
        task.resume()
    }
    
    func fetchPlayerStatistics(_ nhlPlayerList: [NHLPlayer])
    {
        let urlString = ""

        let task = session.dataTask(with: createRequest(urlString))
        {
            (data, response, error) in
            
            if error != nil
            {
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                do
                {
                    let playerStats = try self.decoder.decode(PlayerStats.self, from: data)
                    
                    let playerStatisticsList = self.modelConverter.convertPlayerStatsToPlayerStatisticsList(playerStats.playerStatsTotals!)
                    
                    let updatedNHLPlayerList = self.linkingHelper.linkPlayersToStatistics(with: nhlPlayerList, playerStatisticsList: playerStatisticsList)
                    
                    self.fetchPlayerInjuries(updatedNHLPlayerList)
                }
                catch
                {
                    print(error.localizedDescription)
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
        task.resume()
    }

    func fetchPlayerInjuries(_ nhlPlayerList: [NHLPlayer])
    {
        let urlString = ""

        let task = session.dataTask(with: createRequest(urlString))
        {
            (data, response, error) in
            
            if error != nil
            {
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                do
                {
                    let playerInjuries = try self.decoder.decode(PlayerInjuries.self, from: data)
                    
                    let playerInjuriesList = self.modelConverter.convertPlayerInjuriesToNHLPlayerInjuryList(playerInjuries)
                    
                    let updatedNHLPlayerList = self.linkingHelper.linkPlayersToInjuries(with: nhlPlayerList, injuryList: playerInjuriesList)
                    
                    //  Save the data to the database
                    self.databaseManager.saveRosters(updatedNHLPlayerList)
                    
                    self.delegate?.didPerformNetworkCall(updatedNHLPlayerList)
                }
                catch
                {
                    print(error.localizedDescription)
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNHLStandings()
    {
        let urlString = ""
        
        //performRequest(with: createRequest(urlString))
    }
    
    func fetchScoringSummary()
    {
        let urlString = ""
        
        //performRequest(with: createRequest(urlString))
    }
    
    func fetchGameLog()
    {
        let urlString = ""
        
        //performRequest(with: createRequest(urlString))
    }
    
    func updateScheduleForDate(_ date: Date)
    {
        let urlString = ""
        
        //performRequest(with: createRequest(urlString))
    }
    
    //  Return a request populated with the URL and authorization information
    private func createRequest(_ urlString: String) -> URLRequest
    {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        request.addValue(Constants.AUTHORIZATION_VALUE + Constants.USER_ID.toBase64()!, forHTTPHeaderField: Constants.AUTHORIZATION)
        
        return request
    }
}
