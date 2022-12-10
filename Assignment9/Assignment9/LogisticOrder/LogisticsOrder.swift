//
//  LogisticsOrder.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import Foundation
import GRDB

struct LogisticsOrder: FetchableRecord, MutablePersistableRecord, Codable {
    
    let id: Int
    let fromLocation: Location
    let toLocation: Location
    var departureDate: Date
    var estimatedArrivalDate: Date
    var cost: Int
    var itemsCarried: [OrderItem]
    
    func getDescription() -> String {
        return "Order ID: \(id) \nFrom Location: \(fromLocation.getDescription()) \nTo Location: \(toLocation.getDescription()) \nEstimated Arrival Date: \(estimatedArrivalDate) \nDeparture Date: \(departureDate) \nCost: \(cost) \nItems Carried \(itemsCarried)\n"
    }
}

struct OrderItem: Codable {
    var item: Item
    var quantity: Int
    
    func getDescription() -> String {
        return "\(item.getDescription())\nQuantity: \(quantity)\n"
    }
}

class OrderItems: Codable {
    var items: [OrderItem] {
        didSet {
            orderTotal = getOrderTotal(items: items)
        }
    }
    
    var orderTotal: Int = 0
    
    func getOrderTotal(items: [OrderItem]) -> Int {
        var total = 0
        for item in items {
            let val = item.quantity * item.item.value
            total += val
        }
        return total
    }

    
    init() {
        self.items = []
        orderTotal = 0
    }
    
    init(items: [OrderItem]) {
        self.items = items
        self.orderTotal = getOrderTotal(items: items)
    }
}
