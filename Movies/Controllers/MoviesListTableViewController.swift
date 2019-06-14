//
//  MoviesListTableViewController.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController {
    
    private var cellId = "moviesCell"
    private var movies = [String : [MovieLocation]]()
    private var uniqueMovies = [String]()
    
    struct MoviesObjects {
        
        var movieName : String
        var movieDate : [MovieLocation]
    }
    
    var objectArray = [MoviesObjects]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadMoviesLocation()
    }
    
    private func loadMoviesLocation() {
        NetworkingClient.shared.getMovies { (result) in
            switch result {
            case .success(let moviesLocationList):
                print(moviesLocationList)
             
//                let moviesLocationListSet = Set(moviesLocationList)
//                let uniqueScores = Array(scoresSet)
          
                self.movies = moviesLocationList
                
                for (key, value) in moviesLocationList {
                    print("\(key) -> \(value)")
                    self.objectArray.append(MoviesObjects(movieName: key, movieDate: value))
                    
                }
       
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                break
                
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MoviesTableViewCell else { fatalError() }
        cell.movieName.text = "Movie name: \(objectArray[indexPath.row].movieName)"
       cell.movieDate.text = "Movie date: \(objectArray[indexPath.row].movieDate[0].created_at)"
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "movieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "movieDetail":
                let
                break
            default:
                print("No segue found")
            }
        }
    }
}
