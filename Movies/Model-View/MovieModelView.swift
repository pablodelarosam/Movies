//
//  MovieModelView.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation
import UIKit

struct MovieModelView {
    
    let movieName: String
    
    //Dependency injection 
    init(movieLocation: MovieLocation) {
        self.movieName = movieLocation.title
//        self.movieDate = movieLocation.created_at
    }
    
}


