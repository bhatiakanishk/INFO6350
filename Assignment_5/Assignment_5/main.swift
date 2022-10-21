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
    var street: String
    var city: String
    var state: String
    var country: String
    var zip: String
    
    init(id: Int, street: String, city: String, state: String, country: String, zip: String) {
        self.id = id
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zip = zip
    }
    
    func createLocation() {
        print("Enter location id: ")
        let locationId = Int(readLine() ?? "0") ?? 0
        
        print("Enter street name: ")
        let streetName = readLine() ?? ""
        
        print("Enter city name: ")
        let cityName = readLine() ?? ""
        
        print("Enter state name: ")
        let stateName = readLine() ?? ""
        
        print("Enter country name: ")
        let countryName = readLine() ?? ""
        
        print("Enter zip code: ")
        let zipCode = readLine() ?? ""
        
        locations.append(Location(id: locationId, street: streetName, city: cityName, state: stateName, country: countryName, zip: zipCode))
    }
    
    func viewAllLocations() {
        print(locations)
    }
    
    func updateLocation() {
        print("Enter location id: ")
        let locationId = Int(readLine() ?? "0") ?? 0
        
        print("Enter new street name: ")
        let streetName = readLine() ?? ""
        
        print("Enter new city name: ")
        let cityName = readLine() ?? ""
        
        print("Enter new state name: ")
        let stateName = readLine() ?? ""
        
        print("Enter new country name: ")
        let countryName = readLine() ?? ""
        
        print("Enter new zip code: ")
        let zipCode = readLine() ?? ""
        
        if let locationIndex = locations.firstIndex(where: {$0.id == locationId}) {
            locations[locationIndex].street = stateName
            locations[locationIndex].city = cityName
            locations[locationIndex].state = stateName
            locations[locationIndex].country = countryName
            locations[locationIndex].zip = zipCode
        }
    }
    
    func deleteLocation() {
        print("Enter location id: ")
        let locationId = Int(readLine() ?? "0") ?? 0
        
        if let locationIndex = locations.firstIndex(where: {$0.id == locationId}) {
            locations.remove(at: locationIndex)
            print("Location deleted successfully")
        } else {
            print("Enter valid id: ")
        }
        
        
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

var locations: [Location] = []
var items: [Item] = []
var logisticsOrder = [Int:String]()

locations.append(Location(id: 1, street: "Smith St", city: "Boston", state: "Massachusetts", country: "United States", zip: "02120"))
locations.append(Location(id: 2, street: "3rd St", city: "New York", state: "New York", country: "United States", zip: "10009"))

items.append(Item(id: 10, name: "Xbox", description: "Gaming Console", weight: 2, value: 500))
items.append(Item(id: 11, name: "Sony Headphones", description: "Headphones", weight: 1, value: 150))



func menu() {
    print("Main Menu")
    print("------------------------")
    print("Please select an option:")
    print("1. Item \n2. Location \n3. Logistic Order \n4. Search")
    let option = Int(readLine() ?? "")
//    switch option {
//        case 1:
//
//        default:
//            print("Invalid")
//    }
}

menu()
