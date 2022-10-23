//
//  main.swift
//  Assignment_5
//
//  Created by Kanishk Bhatia on 10/21/22.
//

//The following operations need to be performed:
//A.  LogisticsOrder:
//• Create order
//• Update departure date
//• Update items
//• View all orders
//• Delete order
//B.  Location:
//• Create location
//• View all locations
//• Update location
//• Delete location
//C.  Item:
//• Create item
//• View all items
//• Update item
//• Delete item
//D.  Search:
//• Search order by date
//• Search order by location
//* The items in LogisticsOrder needs to have information about the number of
//each item. You may consider using a dictionary.
//* You may add more classes as you see fit.
//* Add data validation wherever applicable.
//* Outputs are displayed on the console. No need for a graphical UI.
//* The next few assignments will be based on this one.

import Foundation

struct Location {
    let id: Int
    var street: String
    var city: String
    var state: String
    var country: String
    var zip: String
}

struct Item {
    let id: Int
    var name: String
    var description: String
    var weight: Int
    var value: Int
}

struct OrderItem {
    var item: Item
    var quantity: Int
}

struct LogisticsOrder {
    let id: Int
    let fromLocation: String
    let toLocation: String
    let estimatedArrivalDate: Date
    var departureDate: Date
    let cost: Int
    var itemsCarried: [OrderItem]
}

var locations: [Location] = []
var items: [Item] = []
var logisticsOrder: [LogisticsOrder] = []

//var logisticsOrder: [Int: LogisticsOrder] = [1: LogisticsOrder(id: 1, fromLocation: "Boston", toLocation: "New York", estimatedArrivalDate: "11-11-2021", departureDate: "10-10-2022", cost: 10, itemsCarried: 1)]

locations.append(Location(id: 1, street: "Smith St", city: "Boston", state: "Massachusetts", country: "United States", zip: "02120"))
locations.append(Location(id: 2, street: "3rd St", city: "New York", state: "New York", country: "United States", zip: "10009"))

items.append(Item(id: 10, name: "Xbox", description: "Gaming Console", weight: 2, value: 500))
items.append(Item(id: 11, name: "Sony Headphones", description: "Headphones", weight: 1, value: 150))

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM-dd-yyyy"
logisticsOrder.append(LogisticsOrder(id: 21,
                                     fromLocation: "Boston",
                                     toLocation: "New York",
                                     estimatedArrivalDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                     departureDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                     cost: 15,
                                     itemsCarried: 1))

func mainMenu() {
    print("\nMain Menu")
    print("------------------------")
    print("Please select an option:")
    print("1. Item \n2. Location \n3. Logistic Order \n4. Search \n5. Exit")
    let option = Int(readLine() ?? "")
    switch option {
        case 1:
            itemMenu()
        case 2:
            locationMenu()
        case 3:
            mainMenu()
        case 4:
            mainMenu()
        case 5:
            exit(0)
        default:
            print("Invalid input")
            mainMenu()
    }
}



mainMenu()

// MARK: Location Methods
func locationMenu() {
    print("\nLocation Menu")
    print("------------------")
    print("Select an option: \n1. Create Location \n2. View all Locations \n3. Update Location \n4. Delete Location \n5. Back \n6. Exit")
    let menuOption = Int(readLine() ?? "")
    switch menuOption {
    case 1:
        createLocation()
    case 2:
        viewAllLocations()
    case 3:
        updateLocation()
    case 4:
        deleteLocation()
    case 5:
        mainMenu()
    case 6:
        exit(0)
    default:
        print("Invalid input")
    }
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
    print("Location created successfully")
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
        locations[locationIndex].street = streetName
        locations[locationIndex].city = cityName
        locations[locationIndex].state = stateName
        locations[locationIndex].country = countryName
        locations[locationIndex].zip = zipCode
    }
    print("Location updated successfully")
}

func deleteLocation() {
    print("Enter location id: ")
    let locationId = Int(readLine() ?? "0") ?? 0
    
    if let locationIndex = locations.firstIndex(where: {$0.id == locationId}) {
        locations.remove(at: locationIndex)
        print("Location deleted successfully")
    } else {
        print("Location delete failed")
    }
}


// MARK: Item Functions
func itemMenu() {
    print("\nItem Menu")
    print("------------------")
    print("Select an option: \n1. Create Item \n2. View all Items \n3. Update Item \n4. Delete Item \n5. Back \n6. Exit")
    let menuOption = Int(readLine() ?? "")
    switch menuOption {
    case 1:
        createItem()
    case 2:
        viewAllItems()
    case 3:
        updateItem()
    case 4:
        deleteItem()
    case 5:
        mainMenu()
    case 6:
        exit(0)
    default:
        print("Invalid input")
    }
    
}

func createItem() {
    print("Enter item id: ")
    let itemId = Int(readLine() ?? "0") ?? 0
    
    print("Enter item name: ")
    let itemName = readLine() ?? ""
    
    print("Enter item description: ")
    let itemDesc = readLine() ?? ""
    
    print("Enter item weight: ")
    let itemWeight = Int(readLine() ?? "0") ?? 0
    
    print("Enter item value: ")
    let itemValue = Int(readLine() ?? "0") ?? 0
    
    items.append(Item(id: itemId, name: itemName, description: itemDesc, weight: itemWeight, value: itemValue))
    print("Item created successfully")
}

func viewAllItems() {
    print(items)
}

func updateItem() {
    print("Enter item id: ")
    let itemId = Int(readLine() ?? "0") ?? 0
    
    print("Enter new item name: ")
    let itemName = readLine() ?? ""
    
    print("Enter new item description: ")
    let itemDesc = readLine() ?? ""
    
    print("Enter new item weight: ")
    let itemWeight = Int(readLine() ?? "0") ?? 0
    
    print("Enter new item value: ")
    let itemValue = Int(readLine() ?? "0") ?? 0
    
    if let itemIndex = items.firstIndex(where: {$0.id == itemId}) {
        items[itemIndex].name = itemName
        items[itemIndex].description = itemDesc
        items[itemIndex].weight = itemWeight
        items[itemIndex].value = itemValue
    }
    print("Item updated successfully")
}

func deleteItem() {
    print("Enter item id: ")
    let itemId = Int(readLine() ?? "0") ?? 0
    
    if let itemIndex = locations.firstIndex(where: {$0.id == itemId}) {
        locations.remove(at: itemIndex)
        print("Item deleted successfully")
    } else {
        print("Item delete failed")
    }
}

// MARK: Logistics Order
func createOrder() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter from location: ")
    let fromLocation = readLine() ?? ""
    
    print("Enter to location: ")
    let toLocation = readLine() ?? ""
    
    print("Enter arrival date:(MM-dd-yyyy) ")
    let arrivalDate = getDateFromUser()
    
    print("Enter departure date:(MM-dd-yyyy) ")
    let departureDate = getDateFromUser()
    
    print("Enter items: ")
    var items: [OrderItem] = []
    while(true) {
        print("enter item id:")
        
        print("enter item quantity")
        
        items.append(OrderItem(item: <#T##Item#>, quantity: <#T##Int#>))
        
        if readline() == "x" {
            break
        }
    }
    

    let orderCost = getOrderTotal(items: items)
 
    
    logisticsOrder.append(LogisticsOrder(id: orderId, fromLocation: fromLocation, toLocation: toLocation, estimatedArrivalDate: arrivalDate, departureDate: departureDate, cost: orderCost, itemsCarried: items))
}

func getOrderTotal(items: [OrderItem]) -> Int {
    var total = 0
    for item in items {
        let val = item.quantity * item.item.value
        total += val
    }
    return total
}

func getDateFromUser() -> Date {
    let date = readLine() ?? ""
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    if let validDate = dateFormatter.date(from: date) {
        return validDate
    } else {
        print("Invalid date. Enter again")
        return getDateFromUser()
    }
}


func viewAllOrders() {
    print(logisticsOrder)
}

func updateDepartureDate() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter new departure date: ")
    let departureDate = getDateFromUser()
    
    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
        logisticsOrder[orderIndex].departureDate = departureDate
    }
}

func updateItems() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter new items carried: ")
    let itemsCarried = Int(readLine() ?? "0") ?? 0
    
    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
        logisticsOrder[orderIndex].itemsCarried = itemsCarried
    }
}

func deleteOrder() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    if let orderIndex = locations.firstIndex(where: {$0.id == orderId}) {
        locations.remove(at: orderIndex)
        print("Order deleted successfully")
    } else {
        print("Order delete failed")
    }
}

func searchByDate() {
    print("Enter the departure date: ")
    let orderDate = getDateFromUser()
    let orders = logisticsOrder.filter( {$0.departureDate == orderDate || $0.estimatedArrivalDate == orderDate})
    if orders.count > 0 {
        for order in orders {
            print(order)
        }
    } else {
        print("order not found")
    }
}

func searchByLocation() {
    print("Enter the to location: ")
    let location = readLine() ?? ""
    let orders = logisticsOrder.filter( {$0.toLocation == location || $0.fromLocation == location} )
    if orders.count > 0 {
        for order in orders {
            print(order)
        }
    } else {
            print("order not found")
    }
}
