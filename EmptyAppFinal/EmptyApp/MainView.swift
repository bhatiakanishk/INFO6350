//
//  MainView.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var locations: [Location] = []
    var items: [Item] = []
    var logisticsOrder: [LogisticsOrder] = []

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
    }()

    let menuItems = UIView()
    let subMenuItems = UIView()
    var safeFrame: CGRect
    
    let itemView = ItemView()
    let logisticsView = LogisticsOrderview()
    let locationView = LocationView()
    
    let outputView = UIView()

    init() {
        let windowSize = UIApplication.shared.windows[0]
        safeFrame = windowSize.safeAreaLayoutGuide.layoutFrame
        super.init(frame: .zero)
        
        itemView.parent = self
        logisticsView.parent = self
        locationView.parent = self
        
        generateMainMenu()
        generateDummyData()
        outputView.frame = CGRect(x: 0, y: 300, width: safeFrame.width, height: safeFrame.height - 300)
        
        self.addSubview(outputView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateMainMenu() {
        let itemMenuButton: UIButton = {
            let button = UIButton()
            button.setTitle("Items", for: .normal)
            button.frame = CGRect(x: 16, y: 0, width: 80, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        
        let locationMenuButton: UIButton = {
            let button = UIButton()
            button.setTitle("Location", for: .normal)
            button.frame = CGRect(x: 112, y: 0, width: 120, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        
        let logisticsOrderButton: UIButton = {
            let button = UIButton()
            button.setTitle("Logistics Order", for: .normal)
            button.frame = CGRect(x: 248, y: 0, width: 140, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()

        menuItems.addSubview(itemMenuButton)
        menuItems.addSubview(locationMenuButton)
        menuItems.addSubview(logisticsOrderButton)
        
        self.addSubview(menuItems)
        self.addSubview(subMenuItems)
        menuItems.frame = CGRect(x: 0, y: 20, width: safeFrame.width, height: 44)
        subMenuItems.frame = CGRect(x: 0, y: 80, width: safeFrame.width, height: 200)

        
        itemMenuButton.addTarget(self, action: #selector(getItemMenu), for: .touchUpInside)
        locationMenuButton.addTarget(self, action: #selector(getLocationMenu), for: .touchUpInside)
        logisticsOrderButton.addTarget(self, action: #selector(getOrderMenu), for: .touchUpInside)
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
}


extension MainView {
    @objc func displayOutput(object: Any) {
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: outputView.frame.height))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = object as? String ?? ""
        
        self.outputView.addSubview(label)
    }
    
    @objc func getItemMenu() {
        self.outputView.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.addSubview(itemView.getItemsMenu())
    }
    
    @objc func getOrderMenu() {
        self.outputView.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.addSubview(logisticsView.getLogisticsOrderMenu())
    }
    
    @objc func getLocationMenu() {
        self.outputView.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.subviews.forEach { $0.removeFromSuperview() }
        self.subMenuItems.addSubview(locationView.getLocationMenu())
    }
}
