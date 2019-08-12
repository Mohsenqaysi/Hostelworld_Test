//
//  HostelWorldAPI.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class HostelWorldAPI {
    
    static let shared = HostelWorldAPI() // Singleton
    fileprivate static let endpointURLStringAllProperties = "https://private-anon-a53683acf6-practical3.apiary-mock.com/cities/1530/properties/"
    
    fileprivate static let endpointURLStringProperty = "https://private-anon-a53683acf6-practical3.apiary-mock.com/properties/"

    // https://private-anon-a53683acf6-practical3.apiary-mock.com/properties/95319
    open func getAllPropertiesFeed(completion: @escaping (Properties?, Error?) -> ()){
        guard let url = URL(string: HostelWorldAPI.endpointURLStringAllProperties) else {return}
        genaricsRequest(url: url, completion: completion)
    }
    
    open func getPropertyData(withID: String, completion:  @escaping (Hostel?, Error?) -> ()){
        let URLWithID = "\(HostelWorldAPI.endpointURLStringProperty)\(withID)"
//        print("URLWithID: \(URLWithID)")
        guard let url = URL(string: URLWithID) else {return}
        genaricsRequest(url: url, completion: completion)
    }
    
    fileprivate func genaricsRequest<T: Decodable>(url: URL, completion:  @escaping (T?, Error?) -> ()){
        URLSession.shared.dataTask(with: url) { data, _ , error in
            // Error
            if let error = error {
                completion(nil, error)
                return
            }
            // success case
            guard let data = data else {return}
            
            do{
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
                
            } catch let error {
                completion(nil, error)
                print("Failed to decode Data: ", error)
            }
            }.resume()
    }
    
    fileprivate func prepareRequest(urlString: String)-> URLRequest{
        // create GET request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
