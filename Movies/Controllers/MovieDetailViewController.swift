//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import MapKit

class MovieDetailViewController: UIViewController {
    
    var movie = [MovieLocation]()
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Movie location \(movie)")
        self.title = movie[0].title
        // Do any additional setup after loading the view.
        setUpMapview()
    }
    
    private func setUpMapview() {
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        for movielocation in movie {
            guard let location = movielocation.locations else { return }
            setUpAnnotations(location: location, movieName: movielocation.title)
        }
    }
    
    private func setUpAnnotations(location: String, movieName: String) {
         // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = movieName
//                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
