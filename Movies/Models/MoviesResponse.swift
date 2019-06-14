//
//  MoviesResponse.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

struct Column: Codable {
    var fieldName: String
}

struct Meta: Codable {
    var view: View
}

struct View: Codable {
    var columns : [Column]
}

struct MoviesResponse: Decodable {
    
    var meta: Meta
    var data: [[AnyDecodable?]]
}
