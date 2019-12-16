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
    func didPerformNetworkCall<T>(_ networkManager: NetworkManager, decodedData: T)
    func didFailWithError(error: Error)
}

struct NetworkManager
{
    var delegate: NetworkManagerDelegate?
    
    func performRequest<T: Decodable>(with urlString: String, type: T)
    {
        if let url = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url)
            {
                (data, response, error) in
                
                if error != nil
                {
                    self.delegate?.didFailWithError(error: error!)
                    
                    return
                }
                
                if let safeData = data
                {
                    if let decodedData = self.parseJSON(safeData, type: type)
                    {
                        self.delegate?.didPerformNetworkCall(self, decodedData: decodedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON<T:Decodable>(_ data: Data, type: T) -> T?
    {
        let decoder = JSONDecoder()
        
        do
        {
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
            
        }
        catch
        {
            delegate?.didFailWithError(error: error)
        }
        
        return nil
    }
}
