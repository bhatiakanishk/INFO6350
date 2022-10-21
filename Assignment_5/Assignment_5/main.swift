//
//  main.swift
//  Assignment_5
//
//  Created by Kanishk Bhatia on 10/21/22.
//
//cmd line

import Foundation

class Location {
    let id: Int
    let street: String
    let city: String
    let state: String
    let country: String
    let zip: String
    
    init(id: Int, street: String, city: String, state: String, country: String, zip: String) {
        self.id = id
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zip = zip
    }
    
    func createLocation() {
    }
    
    func viewAllLocations() {
    }
    
    func updateLocation() {
    }
    
    func deleteLocation() {
    }
}

class Item {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let value: Int
    
    init(id: Int, name: String, description: String, weight: Int, value: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.weight = weight
        self.value = value
    }
    
    func createItem() {
    }
    
    func viewAllItems() {
    }
    
    func updateItem() {
    }
    
    func deleteItem() {
    }
}

class LogisticsOrder {
    let id: Int
    let fromLocation: String
    let toLocation: String
    let estimatedArrivalDate: Date
    let departureDate: Date
    let cost: Int
    let itemsCarried: Int
    
    init(id: Int, fromLocation: String, toLocation: String, estimatedArrivalDate: Date, departureDate: Date, cost: Int, itemsCarried: Int) {
        self.id = id
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.estimatedArrivalDate = estimatedArrivalDate
        self.departureDate = departureDate
        self.cost = cost
        self.itemsCarried = itemsCarried
    }
    
    func createOrder() {
    }
    
    func viewAllOrders() {
    }
    
    func updateDepartureDate() {
    }
    
    func updateItems() {
    }
    
    func deleteOrder() {
    }
}
