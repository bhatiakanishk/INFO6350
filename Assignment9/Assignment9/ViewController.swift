//
//  ViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    var locations: [Location] = []
    var items: [Item] = []
    var logisticsOrder: [LogisticsOrder] = []
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Main Menu"
        navigationController?.navigationBar.prefersLargeTitles = false
        //addDataToDB()
        generateDummyData()
    }
    
    func generateDummyData() {
        //Fetching dummy data from SQL
        items = DatabaseManager.shared.fetchRecords(type: Item.self)
        locations = DatabaseManager.shared.fetchRecords(type: Location.self)
        logisticsOrder = DatabaseManager.shared.fetchRecords(type: LogisticsOrder.self)
    }
    
    // Dummy data add to db
    func addDataToDB() {
        let location1 = Location(id: 1,
                                  street: "Smith St",
                                  city: "Boston",
                                  state: "Massachusetts",
                                  country: "United States",
                                  zip: "02120")
        let location2 = Location(id: 2,
                                 street: "3rd St",
                                 city: "New York",
                                 state: "New York",
                                 country: "United States",
                                 zip: "10009")

        locations.append(location1)
        locations.append(location2)
        
        let item1 = Item(imageData: UIImage(named: "ps1")?.pngData(),
                         id: 1,
                         name: "Sony PS1",
                         desc: "Gaming Console Playstation 1",
                         weight: 2,
                         value: 100)
        let item2 = Item(imageData: UIImage(named: "ps2")?.pngData(),
                         id: 2,
                         name: "Sony PS2",
                         desc: "Gaming Console Playstation 2",
                         weight: 1,
                         value: 200)
        let item3 = Item(imageData: UIImage(named: "ps3")?.pngData(),
                         id: 3,
                         name: "Sony PS3",
                         desc: "Gaming Console Playstation 3",
                         weight: 2,
                         value: 300)
        let item4 = Item(imageData: UIImage(named: "ps4")?.pngData(),
                         id: 4,
                         name: "Sony PS4",
                         desc: "Gaming Console Playstation 4",
                         weight: 1,
                         value: 400)
        let item5 = Item(imageData: UIImage(named: "ps5")?.pngData(),
                         id: 5,
                         name: "Sony PS5",
                         desc: "Gaming Console Playstation 5",
                         weight: 2,
                         value: 500)
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        items.append(item5)

        let order1 = LogisticsOrder(id: 21,
                                    fromLocation: location1,
                                    toLocation: location2,
                                    departureDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                    estimatedArrivalDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                    cost: 100,
                                    itemsCarried: [OrderItem(item: item1, quantity: 1)])
        logisticsOrder.append(order1)

        DatabaseManager.shared.saveRecord(item: location1)
        DatabaseManager.shared.saveRecord(item: location2)
        DatabaseManager.shared.saveRecord(item: item1)
        DatabaseManager.shared.saveRecord(item: item2)
        DatabaseManager.shared.saveRecord(item: item3)
        DatabaseManager.shared.saveRecord(item: item4)
        DatabaseManager.shared.saveRecord(item: item5)
        DatabaseManager.shared.saveRecord(item: order1)
    }
    
    // Segue between controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to Items
        if let vc = segue.destination as? ItemsTableViewController {
            vc.mainVC = self
        }
        
        // Segue to Location
        if let vc = segue.destination as? LocationTableViewController {
            vc.mainVC = self
        }
        
        // Segue to Order
        if let vc = segue.destination as? LogisticOrderTableViewController {
            vc.mainVC = self
        }
    }
}

// Enum for create and modify
enum ViewControllerMode {
    case create, modify
}
