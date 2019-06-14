//
//  Movie.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

struct MovieLocation: Codable, Hashable {
    var created_at: Int
    var updated_at: Int
    var id: String
    var sid: Int
    
    var locations: String? // CoreLocation Reverse Geocoder 
    
    var title: String
    var release_year: String?
    var fun_facts: String?
    var production_company: String?
    var distributor: String?
    var director: String?
    var locationsGroup: String?
    var writer: String?
    var actor_1: String?
    var actor_2: String?
    var actor_3: String?
    
    enum CodingKeys: String, CodingKey {
        case id = ":id"
        case sid = ":sid"
        case created_at = ":created_at"
        case updated_at = ":updated_at"
        case title = "title"
        case release_year = "release_year"
        case actor_1 = "actor_1"
        case actor_2 = "actor_2"
        case actor_3 = "actor_3"
        case locations = "locations"
    }
    
}
