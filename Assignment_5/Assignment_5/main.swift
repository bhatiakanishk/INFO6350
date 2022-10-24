//
//  main.swift
//  Assignment_5
//
//  Created by Kanishk Bhatia on 10/21/22.
//
import Foundation

//Structure for Location
struct Location {
    let id: Int
    var street: String
    var city: String
    var state: String
    var country: String
    var zip: String
    
    func getDescription() -> String {
        return "Location ID: \(id) \nStreet: \(street) \nCity: \(city) \nState: \(state) \nCountry: \(country) \nZip Code: \(zip) \n"
    }
}

//Structure for Item
struct Item {
    let id: Int
    var name: String
    var desc: String
    var weight: Int
    var value: Int
    
    func getDescription() -> String {
        return "Item ID: \(id) \nName: \(name) \nDescription: \(desc) \nWeight: \(weight) \nValue: \(value) \n"
    }
}

//Structure for Order Item
struct OrderItem {
    var item: Item
    var quantity: Int
}

//Structure for Logistic Order
struct LogisticsOrder {
    let id: Int
    let fromLocation: String
    let toLocation: String
    let estimatedArrivalDate: Date
    var departureDate: Date
    var cost: Int
    var itemsCarried: [OrderItem]
    
    func getDescription() -> String {
        return "Task ID: \(id) \nFrom Location: \(fromLocation) \nTo Location: \(toLocation) \nEstimated Arrival Date: \(estimatedArrivalDate) \nDeparture Date: \(departureDate) \nCost: \(cost) \nItems Carried \(itemsCarried) \n"
    }
}

//Location array
var locations: [Location] = []

//Item array
var items: [Item] = []

//LogisticOrder array
var logisticsOrder: [LogisticsOrder] = []

//Location data
locations.append(Location(id: 1,
                          street: "Smith St",
                          city: "Boston",
                          state: "Massachusetts",
                          country: "United States",
                          zip: "02120"))
locations.append(Location(id: 2,
                          street: "3rd St",
                          city: "New York",
                          state: "New York",
                          country: "United States",
                          zip: "10009"))

//Item data
items.append(Item(id: 10,
                  name: "Xbox",
                  desc: "Gaming Console",
                  weight: 2,
                  value: 500))
items.append(Item(id: 11,
                  name: "Sony Headphones",
                  desc: "Headphones",
                  weight: 1,
                  value: 150))

//Date formatting
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM-dd-yyyy"

//Logistic Order data
logisticsOrder.append(LogisticsOrder(id: 21,
                                     fromLocation: "Boston",
                                     toLocation: "New York",
                                     estimatedArrivalDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                     departureDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                     cost: 15,
                                     itemsCarried: [OrderItem(item: Item(id: 10, name: "Xbox", desc: "Gaming Console", weight: 2, value: 500), quantity: 1)]))

//Main menu function
func mainMenu() {
    print("\nMain Menu")
    print("------------------------")
    print("Please select an option:")
    print("1. Item \n2. Location \n3. Logistic Order \n4. Exit")
    let mainMenuOption = Int(readLine() ?? "")
    switch mainMenuOption {
        case 1:
            itemMenu()
        case 2:
            locationMenu()
        case 3:
            logisticsOrderMenu()
        case 4:
            exit(0)
        default:
            print("Invalid input")
            mainMenu()
    }
}

mainMenu()

// MARK: Location Methods
//Location menu function
func locationMenu() {
    print("\nLocation Menu")
    print("------------------")
    print("Select an option: \n1. Create Location \n2. View all Locations \n3. Update Location \n4. Delete Location \n5. Back \n6. Exit")
    let locationMenuOption = Int(readLine() ?? "")
    switch locationMenuOption {
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

//Create location function
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
    locationMenu()
}

//View all locations function
func viewAllLocations() {
    for location in locations {
        print(location.getDescription())
    }
    locationMenu()
}

//Update location function
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
    locationMenu()
}

//Delete location function
func deleteLocation() {
    print("Enter location id: ")
    let locationId = Int(readLine() ?? "0") ?? 0
    
    if let locationIndex = locations.firstIndex(where: {$0.id == locationId}) {
        locations.remove(at: locationIndex)
        print("Location deleted successfully")
        locationMenu()
    } else {
        print("Location delete failed")
        locationMenu()
    }
}


// MARK: Item Functions
//Item menu function
func itemMenu() {
    print("\nItem Menu")
    print("------------------")
    print("Select an option: \n1. Create Item \n2. View all Items \n3. Update Item \n4. Delete Item \n5. Back \n6. Exit")
    let itemMenuOption = Int(readLine() ?? "")
    switch itemMenuOption {
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

//Create item function
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
    
    items.append(Item(id: itemId, name: itemName, desc: itemDesc, weight: itemWeight, value: itemValue))
    print("Item created successfully")
    itemMenu()
}

//View all items function
func viewAllItems() {
    for item in items {
        print(item.getDescription())
    }
    itemMenu()
}

//Update item function
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
        items[itemIndex].desc = itemDesc
        items[itemIndex].weight = itemWeight
        items[itemIndex].value = itemValue
        print("Item updated successfully")
        itemMenu()
    } else {
        print("Item updated failed")
        itemMenu()
    }
}

//Delete item function
func deleteItem() {
    print("Enter item id: ")
    let itemId = Int(readLine() ?? "0") ?? 0
    
    if let itemIndex = items.firstIndex(where: {$0.id == itemId}) {
        items.remove(at: itemIndex)
        print("Item deleted successfully")
        itemMenu()
    } else {
        print("Item delete failed")
        itemMenu()
    }
}

// MARK: Logistics Order
//Logistic Order menu function
func logisticsOrderMenu() {
    print("\nLogistics Order Menu")
    print("------------------")
    print("Select an option: \n1. Create order \n2. View all Orders \n3. Update Departure Date \n4. Update Items \n5. Delete Order \n6. Search by Date \n7. Search by location \n8. Back \n9. Exit")
    let logisticOrderMenuOption = Int(readLine() ?? "")
    switch logisticOrderMenuOption {
    case 1:
        createOrder()
    case 2:
        viewAllOrders()
    case 3:
        updateDepartureDate()
    case 4:
        updateItems()
    case 5:
        deleteOrder()
    case 6:
        searchByDate()
    case 7:
        searchByLocation()
    case 8:
        mainMenu()
    case 9:
        exit(0)
    default:
        print("Invalid input")
    }
}

//Create order function
func createOrder() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter from location id: ")
    let fromLocation = readLine() ?? ""
//    if let fromLocationIndex = locations.firstIndex(where: {$0.id == fromLocationId}) {
//        let fromLocation = locations[fromLocationIndex]
//        print(fromLocation)
//    } else {
//        print("Invalid id")
//    }
    
    print("Enter to location id: ")
    let toLocation = readLine() ?? ""
    
    print("Enter arrival date:(MM-dd-yyyy) ")
    let arrivalDate = getDateFromUser()
    
    print("Enter departure date:(MM-dd-yyyy) ")
    let departureDate = getDateFromUser()
    
    print("Enter items: ")
    var orderItems: [OrderItem] = []
    while(true) {
        print("Enter item id: (Enter 99 to exit)")
        let itemId = Int(readLine() ?? "0") ?? 0
        if itemId == 99 {
            break
        } else {
            print("Enter item quantity")
            let quantity = Int(readLine() ?? "0") ?? 0
            
            if let itemIndex = items.firstIndex(where: {$0.id == itemId}) {
                orderItems.append(OrderItem(item: items[itemIndex], quantity: quantity))
            } else {
                print("Invalid input")
            }
        }
    }
    let orderCost = getOrderTotal(items: orderItems)
    logisticsOrder.append(LogisticsOrder(id: orderId, fromLocation: fromLocation, toLocation: toLocation, estimatedArrivalDate: arrivalDate, departureDate: departureDate, cost: orderCost, itemsCarried: orderItems))
    logisticsOrderMenu()
}

//Order total function
func getOrderTotal(items: [OrderItem]) -> Int {
    var total = 0
    for item in items {
        let val = item.quantity * item.item.value
        total += val
    }
    return total
}

//Get date from user function
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

//View all orders function
func viewAllOrders() {
    for order in logisticsOrder {
        print(order.getDescription())
    }
    logisticsOrderMenu()
}

//Update departure date function
func updateDepartureDate() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter new departure date: ")
    let departureDate = getDateFromUser()
    
    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
        logisticsOrder[orderIndex].departureDate = departureDate
        print("Departure date updated")
        logisticsOrderMenu()
    } else {
        print("Departure date failed")
        logisticsOrderMenu()
    }
}

//Update order item function
func updateItems() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
        //logisticsOrder[orderIndex].itemsCarried =
        print("Enter items: ")
        var orderItems: [OrderItem] = []
        while(true) {
            print("Enter item id: (Enter 99 to exit)")
            let itemId = Int(readLine() ?? "0") ?? 0
            if itemId == 99 {
                break
            } else {
                print("Enter item quantity")
                let quantity = Int(readLine() ?? "0") ?? 0
                
                if let itemIndex = items.firstIndex(where: {$0.id == itemId}) {
                    orderItems.append(OrderItem(item: items[itemIndex], quantity: quantity))
                } else {
                    print("Invalid input")
                }
            }
        }
        let orderCost = getOrderTotal(items: orderItems)
        logisticsOrder[orderIndex].itemsCarried = orderItems
        logisticsOrder[orderIndex].cost = orderCost
        print("Order updated successfully")
        logisticsOrderMenu()
    } else {
        print("Order update failed")
        logisticsOrderMenu()
    }
}

//Delete order function
func deleteOrder() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
        logisticsOrder.remove(at: orderIndex)
        print("Order deleted successfully")
        logisticsOrderMenu()
    } else {
        print("Order delete failed")
        logisticsOrderMenu()
    }
}

//Search order by date function
func searchByDate() {
    print("Enter the departure date: ")
    let orderDate = getDateFromUser()
    let orders = logisticsOrder.filter( {$0.departureDate == orderDate || $0.estimatedArrivalDate == orderDate})
    if orders.count > 0 {
        for order in orders {
            print(order)
            logisticsOrderMenu()
        }
    } else {
        print("Order not found")
        logisticsOrderMenu()
    }
}

//Search order by location function
func searchByLocation() {
    print("Enter the location: ")
    let location = readLine() ?? ""
    let orders = logisticsOrder.filter( {$0.toLocation == location || $0.fromLocation == location} )
    if orders.count > 0 {
        for order in orders {
            print(order)
            logisticsOrderMenu()
        }
    } else {
        print("Order not found")
        logisticsOrderMenu()
    }
}
