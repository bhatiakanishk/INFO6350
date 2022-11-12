//
//  MainViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/4/22.
//

import UIKit

class MainViewController: UIViewController {
    
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
//        addDataToDB()
        generateDummyData()
    }
    
    func generateDummyData() {
        // fetching dummy data from SQL
        items = DatabaseManager.shared.fetchRecords(type: Item.self)
        locations = DatabaseManager.shared.fetchRecords(type: Location.self)
        logisticsOrder = DatabaseManager.shared.fetchRecords(type: LogisticsOrder.self)
    }
    
    func addDataToDB() {
        let location1 = Location(id: 1,
                                  street: "Smith St",
                                  city: "Boston",
                                  state: "Massachusetts",
                                  country: "United States",
                                  zip: 02120)
        let location2 = Location(id: 2,
                                 street: "3rd St",
                                 city: "New York",
                                 state: "New York",
                                 country: "United States",
                                 zip: 10009)

        locations.append(location1)
        locations.append(location2)
        
        let item1 = Item(id: 10,
                         name: "Xbox",
                         desc: "Gaming Console",
                         weight: 2,
                         value: 500)
        
        let item2 = Item(id: 11,
                         name: "Sony Headphones",
                         desc: "Headphones",
                         weight: 1,
                         value: 150)
        
        items.append(item1)
        items.append(item2)
        
        
        let order1 = LogisticsOrder(id: 21,
                                    fromLocation: location1,
                                    toLocation: location2,
                                    estimatedArrivalDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                    departureDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                    cost: 15,
                                    itemsCarried: [OrderItem(item: Item(id: 10, name: "Xbox", desc: "Gaming Console", weight: 2, value: 500), quantity: 1)])
        logisticsOrder.append(order1)
    

        DatabaseManager.shared.saveRecord(item: location1)
        DatabaseManager.shared.saveRecord(item: location2)
        DatabaseManager.shared.saveRecord(item: item1)
        DatabaseManager.shared.saveRecord(item: item2)
        DatabaseManager.shared.saveRecord(item: order1)
    }
    
    @IBAction func onItemButtonClicked(_ sender: UIButton) {
        let vc = ItemViewController(nibName: "ItemView", bundle: nil)
        vc.mainVC = self
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onLocationButtonClicked(_ sender: UIButton) {
        let vc = LocationViewController(nibName: "LocationView", bundle: nil)
        vc.mainVC = self
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onLogisticOrderButtonClicked(_ sender: UIButton) {
        let vc = OrderViewController(nibName: "OrderView", bundle: nil)
        vc.mainVC = self
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
 
}
