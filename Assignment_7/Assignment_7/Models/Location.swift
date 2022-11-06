//
//  Location.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import Foundation

struct Location {
    let id: Int
    var street: String
    var city: String
    var state: String
    var country: String
    var zip: Int
    
    func getDescription() -> String {
        return "Location ID: \(id) \nStreet: \(street) \nCity: \(city) \nState: \(state) \nCountry: \(country) \nZip: \(zip)\n"
    }
}
