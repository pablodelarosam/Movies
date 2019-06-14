//
//  Extensions.swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/13/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation


extension Int {
    func unixDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "es_MX")
        let Unix = formatter.string(from: Date(timeIntervalSince1970: Double(self)))
        print(Unix)
        return Unix
    }
}
