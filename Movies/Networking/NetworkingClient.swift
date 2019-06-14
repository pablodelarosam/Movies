//
//  File.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

enum Result <T: Codable> {
    case success(_ items: [String: [MovieLocation]])
    case failure(_ error: Error)
}


/*
 // DATA FLOW
 
 
 Network API -> Core Data
 - When the app starts
 - Whent the user refreshes the data manually (e.g.: pull to refresh on the UITableView)
 
 Core Data -> UI
 
 */

public final class NetworkingClient {
    
    static var shared = NetworkingClient()
    
    func getMovies(completion: @escaping (_ result: Result<[String : [MovieLocation]]>)->Void) {
        
        let url = URL(string: "https://data.sfgov.org/api/views/yitu-d5am/rows.json?accessType=DOWNLOAD")!
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let data = data {
                
                let decoder = JSONDecoder()
                do {
                    let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                    
                    var movieJSONArray = [[String: Any]]()
                    for movieData in moviesResponse.data {
                        var movieJSON = [String: Any]()
                        var index = 0
                        
                        // Loop through the columns
                        for column in moviesResponse.meta.view.columns {
                            // Generate the proper JSON
                            if let value = movieData[index] {
                                movieJSON[column.fieldName] = value.value
                            }
                            index += 1
                        }
                        movieJSONArray.append(movieJSON)
                    }
                    
                    // Map the JSON to the Codable Movie struct
                    let jsonData = try JSONSerialization.data(withJSONObject: movieJSONArray, options: .prettyPrinted)
                    let movies = try decoder.decode([MovieLocation].self, from: jsonData)
//                    No I don't. just run a loop and group if same movies
                 let groupedMovies =  Dictionary(grouping: movies, by: { $0.title })
                    
                    print(groupedMovies)
                    completion(.success(groupedMovies))
                    
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    let error = NSError(domain: "Generic Error", code: 500, userInfo: nil)
                    completion(.failure(error))
                }
            }
            
            }
        task.resume()
    }
    

    
}
