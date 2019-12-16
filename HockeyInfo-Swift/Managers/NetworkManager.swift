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
    func didPerformNetworkCall(_ data: Data)
    func didFailWithError(error: Error)
}

struct NetworkManager
{
    var delegate: NetworkManagerDelegate?
    
    func fetchSeasonSchedule()
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    func fetchRosterPlayers()
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    func fetchNHLStandings()
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    func fetchScoringSummary()
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    func fetchGameLog()
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    func updateScheduleForDate(_ date: Date)
    {
        let urlString = ""
        
        performRequest(with: createRequest(urlString))
    }
    
    //  Perform a network request and call didPerformNetworkCall on the delegate
    func performRequest(with request: URLRequest)
    {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request)
        {
            (data, response, error) in
            
            if error != nil
            {
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                self.delegate?.didPerformNetworkCall(data)
            }
        }
        task.resume()
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
