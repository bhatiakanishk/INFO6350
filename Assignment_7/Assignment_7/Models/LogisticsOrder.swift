//
//  LogisticsOrder.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import Foundation

struct LogisticsOrder {
    let id: Int
    let fromLocation: Location
    let toLocation: Location
    let estimatedArrivalDate: Date
    var departureDate: Date
    var cost: Int
    var itemsCarried: [OrderItem]
    
    func getDescription() -> String {
        return "Order ID: \(id) \nFrom Location: \(fromLocation.getDescription()) \nTo Location: \(toLocation.getDescription()) \nEstimated Arrival Date: \(estimatedArrivalDate) \nDeparture Date: \(departureDate) \nCost: \(cost) \nItems Carried \(itemsCarried)\n"
    }
}

struct OrderItem {
    var item: Item
    var quantity: Int
    
    func getDescription() -> String {
        return "\(item.getDescription())\nQuantity: \(quantity)\n"
    }
    
}
