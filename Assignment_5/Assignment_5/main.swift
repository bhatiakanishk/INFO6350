//
//  main.swift
//  Assignment_5
//
//  Created by Kanishk Bhatia on 10/21/22.
//
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

items.append(Item(id: 10,
                  name: "Xbox",
                  description: "Gaming Console",
                  weight: 2,
                  value: 500))
items.append(Item(id: 11,
                  name: "Sony Headphones",
                  description: "Headphones",
                  weight: 1,
                  value: 150))

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM-dd-yyyy"
logisticsOrder.append(LogisticsOrder(id: 21,
                                     fromLocation: "Boston",
                                     toLocation: "New York",
                                     estimatedArrivalDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                     departureDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                     cost: 15,
                                     itemsCarried: [OrderItem(item: Item(id: 10, name: "Xbox", description: "Gaming Console", weight: 2, value: 500), quantity: 1)]))

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

func viewAllLocations() {
    print(locations)
    locationMenu()
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
    locationMenu()
}

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
    itemMenu()
}

func viewAllItems() {
    print(items)
    itemMenu()
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
        print("Item updated successfully")
        itemMenu()
    } else {
        print("Item updated failed")
        itemMenu()
    }
}

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
        print("Enter item id: (Enter 99 to exit)")
        let itemId = Int(readLine() ?? "0") ?? 0
        print("Enter item quantity")
        let quantity = Int(readLine() ?? "0") ?? 0
//        items.append(OrderItem(item: Item(id: itemId,
//                                          name: String,
//                                          description: <#T##String#>,
//                                          weight: <#T##Int#>,
//                                          value: <#T##Int#>),
//                               quantity: quantity))
        
        //items.append(OrderItem(item: <#Item#>, quantity: quantity))
        if itemId == 99 {
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
    logisticsOrderMenu()
}

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

func updateItems() {
    print("Enter order id: ")
    let orderId = Int(readLine() ?? "0") ?? 0
    
    print("Enter new items carried: ")
    let itemsCarried = Int(readLine() ?? "0") ?? 0
    
//    if let orderIndex = logisticsOrder.firstIndex(where: {$0.id == orderId}) {
//        logisticsOrder[orderIndex].itemsCarried = [LogisticsOrder].[itemsCarried].[items]
//        print("Order updated successfully")
//        logisticsOrderMenu()
//    } else {
//        print("Order update failed")
//        logisticsOrderMenu()
//}
}

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

func searchByLocation() {
    print("Enter the to location: ")
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
