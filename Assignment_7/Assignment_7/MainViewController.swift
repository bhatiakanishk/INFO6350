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
        generateDummyData()
    }
    
    func generateDummyData() {
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
        logisticsOrder.append(LogisticsOrder(id: 21,
                                             fromLocation: location1,
                                             toLocation: location2,
                                             estimatedArrivalDate: dateFormatter.date(from: "07-21-2023") ?? Date(),
                                             departureDate: dateFormatter.date(from: "09-21-2023") ?? Date(),
                                             cost: 15,
                                             itemsCarried: [OrderItem(item: Item(id: 10, name: "Xbox", desc: "Gaming Console", weight: 2, value: 500), quantity: 1)]))
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
        let vc = LogisticOrderViewController(nibName: "LogisticOrderView", bundle: nil)
        vc.mainVC = self
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
 
}
