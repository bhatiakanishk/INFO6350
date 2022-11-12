//
//  Item.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import Foundation
import GRDB

struct Item: FetchableRecord, MutablePersistableRecord, Codable {
    let id: Int
    var name: String
    var desc: String
    var weight: Int
    var value: Int
    
    func getDescription() -> String {
        return "Item ID: \(id) \nName: \(name) \nDescription: \(desc) \nWeight: \(weight) \nValue: \(value)\n"
    }
}
