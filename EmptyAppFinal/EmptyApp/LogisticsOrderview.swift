//
//  LogisticsOrderview.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import UIKit

class LogisticsOrderview: UIView {
    
    var safeFrame: CGRect
    var parent: MainView?
    
    init() {
        let windowSize = UIApplication.shared.windows[0]
        safeFrame = windowSize.safeAreaLayoutGuide.layoutFrame
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getLogisticsOrderMenu() -> UIView {
        let logisticsOrderCreateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Create Order", for: .normal)
            button.frame = CGRect(x: 8, y: 0, width: 200, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderCreateButton.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
        
        let logisticsOrderViewButton: UIButton = {
            let button = UIButton()
            button.setTitle("View Order", for: .normal)
            button.frame = CGRect(x: 8, y: 52, width: 200, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderViewButton.addTarget(self, action: #selector(viewOrders), for: .touchUpInside)
        
        let logisticsOrderDepartureDateUpdateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Update Departure Date", for: .normal)
            button.frame = CGRect(x: 8, y: 104, width: 200, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderDepartureDateUpdateButton.addTarget(self, action: #selector(updateDepartureDate), for: .touchUpInside)
        
        let logisticsOrderItemsUpdateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Update Items", for: .normal)
            button.frame = CGRect(x: 8, y: 156, width: 200, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderItemsUpdateButton.addTarget(self, action: #selector(updateOrderItems), for: .touchUpInside)

        
        let logisticsOrderDeleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Delete Orders", for: .normal)
            button.frame = CGRect(x: 216, y: 0, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderDeleteButton.addTarget(self, action: #selector(deleteOrder), for: .touchUpInside)
        
        let logisticsOrderSearchDateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Search by Date", for: .normal)
            button.frame = CGRect(x: 216, y: 52, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderSearchDateButton.addTarget(self, action: #selector(searchOrderByDate), for: .touchUpInside)

        let logisticsOrderSearchLocationButton: UIButton = {
            let button = UIButton()
            button.setTitle("Search by Location", for: .normal)
            button.frame = CGRect(x: 216, y: 104, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        logisticsOrderSearchLocationButton.addTarget(self, action: #selector(searchOrderByLocation), for: .touchUpInside)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: safeFrame.width, height: 200))
        view.addSubview(logisticsOrderCreateButton)
        view.addSubview(logisticsOrderViewButton)
        view.addSubview(logisticsOrderDepartureDateUpdateButton)
        view.addSubview(logisticsOrderItemsUpdateButton)
        view.addSubview(logisticsOrderDeleteButton)
        view.addSubview(logisticsOrderSearchDateButton)
        view.addSubview(logisticsOrderSearchLocationButton)
        return view
    }
    
    @objc func createOrder() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfOrderId = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 24))
        tfOrderId.placeholder = "Enter order id"
        tfOrderId.borderStyle = .roundedRect

        let tfFromLocation = UITextField(frame: CGRect(x: 16, y: 48, width: safeFrame.width - 32, height: 24))
        tfFromLocation.placeholder = "Enter From location id"
        tfFromLocation.borderStyle = .roundedRect
        
        let tfToLocation = UITextField(frame: CGRect(x: 16, y: 80, width: safeFrame.width - 32, height: 24))
        tfToLocation.placeholder = "Enter To location id"
        tfToLocation.borderStyle = .roundedRect
        
        let tfArrivalDate = UITextField(frame: CGRect(x: 16, y: 112, width: safeFrame.width - 32, height: 24))
        tfArrivalDate.placeholder = "Enter arrival date:(MM-dd-yyyy)"
        tfArrivalDate.borderStyle = .roundedRect
        
        let tfDepartureDate = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfDepartureDate.placeholder = "Enter departure date:(MM-dd-yyyy)"
        tfDepartureDate.borderStyle = .roundedRect
        
        let tfItemId = UITextField(frame: CGRect(x: 16, y: 176, width: safeFrame.width - 32, height: 24))
        tfItemId.placeholder = "Enter item id"
        tfItemId.borderStyle = .roundedRect
        
        let tfItemQuantity = UITextField(frame: CGRect(x: 16, y: 208, width: safeFrame.width - 32, height: 24))
        tfItemQuantity.placeholder = "Enter item quantity"
        tfItemQuantity.borderStyle = .roundedRect
        
        
        let button = UIButton(frame: CGRect(x: 16, y: 240, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Create Order", handler: { _ in
            
            // Order Id
            guard let orderId = Int(tfOrderId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Order Id")
                return
            }
            if let _ = parent.logisticsOrder.firstIndex(where: {$0.id == orderId}) {
                self.showAlert(title: "Error", message: "Order id already exists")
                return
            }
            
            // From Location
            guard let fromLocationId = Int(tfFromLocation.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid From Location Id")
                return
            }
            var fromLocation: Location
            if let fromLocationIndex = parent.locations.firstIndex(where: {$0.id == fromLocationId} ) {
                // from location valid
                fromLocation = parent.locations[fromLocationIndex]
            } else {
                self.showAlert(title: "Error", message: "From Location does not exist")
                return
            }
            
            // To Location
            guard let toLocationId = Int(tfToLocation.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid To Location Id")
                return
            }
            var toLocation: Location
            if let toLocationIndex = parent.locations.firstIndex(where: {$0.id == toLocationId} ) {
                // from location valid
                toLocation = parent.locations[toLocationIndex]
            } else {
                self.showAlert(title: "Error", message: "To Location does not exist")
                return
            }
            
            // Arrival Date
            guard let arrivalDateString = tfArrivalDate.text else {
                self.showAlert(title: "Error", message: "Arrival date is empty")
                return
            }
            if arrivalDateString.isEmpty {
                self.showAlert(title: "Error", message: "Arrival date is empty")
                return
            }
            guard let arrivalDate = self.validateDate(enteredDate: arrivalDateString) else {
                self.showAlert(title: "Error", message: "Arrival date format invalid")
                return
            }

            // Departure Date
            guard let departureDateString = tfDepartureDate.text else {
                self.showAlert(title: "Error", message: "Departure date is empty")
                return
            }
            if departureDateString.isEmpty {
                self.showAlert(title: "Error", message: "Departure date is empty")
                return
            }
            guard let departureDate = self.validateDate(enteredDate: departureDateString) else {
                self.showAlert(title: "Error", message: "Departure date format invalid")
                return
            }
            
            if arrivalDate < departureDate {
                self.showAlert(title: "Error", message: "Arrival date cannot be before departure date")
                return
            }
            
            // Item id
            guard let itemId = Int(tfItemId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
                return
            }
            var item: Item
            if let itemIndex = parent.items.firstIndex(where: {$0.id == itemId} ) {
                // from location valid
                item = parent.items[itemIndex]
            } else {
                self.showAlert(title: "Error", message: "Item does not exist")
                return
            }
            
            // Item quantity
            guard let quantity = Int(tfItemQuantity.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Quantity")
                return
            }
            
            let orderItems = [OrderItem(item: item, quantity: quantity)]
            let orderCost = self.getOrderTotal(items: orderItems)
            
            parent.logisticsOrder.append(LogisticsOrder(id: orderId, fromLocation: fromLocation, toLocation: toLocation, estimatedArrivalDate: arrivalDate, departureDate: departureDate, cost: orderCost, itemsCarried: orderItems))

            self.showAlert(title: "Success", message: "Order created successfully")
        }))
        
        button.backgroundColor = .systemGreen
        
        parent.outputView.addSubview(tfOrderId)
        parent.outputView.addSubview(tfFromLocation)
        parent.outputView.addSubview(tfToLocation)
        parent.outputView.addSubview(tfArrivalDate)
        parent.outputView.addSubview(tfDepartureDate)
        parent.outputView.addSubview(tfItemId)
        parent.outputView.addSubview(tfItemQuantity)
        parent.outputView.addSubview(button)
    }
    
    
    @objc func searchOrderByDate() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfDate = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 200, height: 24))
        tfDate.placeholder = "Enter order date (MM-dd-yyyy):"
        tfDate.borderStyle = .roundedRect
        
        let textView = UITextView(frame: CGRect(x: 16, y: 64, width: safeFrame.width - 32, height: parent.outputView.frame.height - 80))
        
        let searchButton = UIButton(frame: CGRect(x: 200, y: 16, width: safeFrame.width - 240, height: 40), primaryAction: UIAction(title: "Search Order", handler: { _ in
            guard let enteredDateString = tfDate.text else {
                self.showAlert(title: "Error", message: "Date is empty")
                return
            }
            if enteredDateString.isEmpty {
                self.showAlert(title: "Error", message: "Date is empty")
                return
            }
            guard let orderDate = self.validateDate(enteredDate: enteredDateString) else {
                self.showAlert(title: "Error", message: "Departure date format invalid")
                return
            }

            let orders = parent.logisticsOrder.filter( {$0.departureDate == orderDate || $0.estimatedArrivalDate == orderDate})

            if orders.count > 0 {
                var outputStr = ""
                for order in orders {
                    outputStr.append(order.getDescription())
                    outputStr.append("\n")
                }
                textView.text = outputStr
            } else {
                textView.text = "No orders found"
            }
        }))

        searchButton.backgroundColor = .systemBlue
        parent.outputView.addSubview(tfDate)
        parent.outputView.addSubview(searchButton)
        parent.outputView.addSubview(textView)
    }
    
    @objc func searchOrderByLocation() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfLocationId = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 24))
        tfLocationId.placeholder = "Enter location id:"
        tfLocationId.borderStyle = .roundedRect
        
        let textView = UITextView(frame: CGRect(x: 16, y: 64, width: safeFrame.width - 32, height: parent.outputView.frame.height - 80))
        
        
        let searchButton = UIButton(frame: CGRect(x: 160, y: 16, width: safeFrame.width - 200, height: 40), primaryAction: UIAction(title: "Search Order", handler: { _ in
            guard let location = Int(tfLocationId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Location Id")
                return
            }
            
            let orders = parent.logisticsOrder.filter( {$0.toLocation.id == location || $0.fromLocation.id == location} )
            if orders.count > 0 {
                var outputStr = ""
                for order in orders {
                    outputStr.append(order.getDescription())
                    outputStr.append("\n")
                }
                textView.text = outputStr
            } else {
                textView.text = "No orders found"
            }
        }))

        searchButton.backgroundColor = .systemBlue
        parent.outputView.addSubview(tfLocationId)
        parent.outputView.addSubview(searchButton)
        parent.outputView.addSubview(textView)
    }
    
    
    @objc func viewOrders() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        let textView = UITextView(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: parent.outputView.frame.height - 32))
        var outputStr = ""
        for item in parent.logisticsOrder {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No orders exist" : outputStr
        parent.outputView.addSubview(textView)
    }
    
    @objc func updateDepartureDate() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfOrderId = UITextField(frame: CGRect(x: 16, y: 16, width: 120, height: 24))
        tfOrderId.placeholder = "Enter order id:"
        tfOrderId.borderStyle = .roundedRect
        
        let tfDepartureDate = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfDepartureDate.placeholder = "Enter departure date:(MM-dd-yyyy)"
        tfDepartureDate.borderStyle = .roundedRect

        var orderFoundIndex: Int = -99
                
        let updateButton = UIButton(frame: CGRect(x: 16, y: 180, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Update Order", handler: { _ in
            
            // Departure Date
            guard let departureDateString = tfDepartureDate.text else {
                self.showAlert(title: "Error", message: "Departure date is empty")
                return
            }
            if departureDateString.isEmpty {
                self.showAlert(title: "Error", message: "Departure date is empty")
                return
            }
            guard let departureDate = self.validateDate(enteredDate: departureDateString) else {
                self.showAlert(title: "Error", message: "Departure date format invalid")
                return
            }

            parent.logisticsOrder[orderFoundIndex].departureDate = departureDate
            self.showAlert(title: "Success", message: "Order departure date updated successfully")
        }))
        
        updateButton.isEnabled = false
        
        let fetchButton = UIButton(frame: CGRect(x: 160, y: 16, width: safeFrame.width - 200, height: 40), primaryAction: UIAction(title: "Fetch Order", handler: { _ in
            guard let orderId = Int(tfOrderId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Order Id")
                return
            }
            if let orderIndex = parent.logisticsOrder.firstIndex(where: {$0.id == orderId}) {
                orderFoundIndex = orderIndex
                tfOrderId.isEnabled = false
                let order = parent.logisticsOrder[orderIndex]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                tfDepartureDate.text = dateFormatter.string(from: order.departureDate)
                updateButton.isEnabled = true
            } else {
                self.showAlert(title: "Error", message: "Order id does not exist")
                return
            }
        }))
        
        updateButton.backgroundColor = .systemGreen
        fetchButton.backgroundColor = .systemBlue
        
        parent.outputView.addSubview(tfOrderId)
        parent.outputView.addSubview(fetchButton)
        parent.outputView.addSubview(tfDepartureDate)
        parent.outputView.addSubview(updateButton)
    }

    @objc func updateOrderItems() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfOrderId = UITextField(frame: CGRect(x: 16, y: 16, width: 120, height: 24))
        tfOrderId.placeholder = "Enter order id:"
        tfOrderId.borderStyle = .roundedRect

        let tfItemId = UITextField(frame: CGRect(x: 16, y: 56, width: safeFrame.width - 32, height: 24))
        tfItemId.placeholder = "Enter item id"
        tfItemId.borderStyle = .roundedRect
        
        let tfItemQuantity = UITextField(frame: CGRect(x: 16, y: 88, width: safeFrame.width - 32, height: 24))
        tfItemQuantity.placeholder = "Enter item quantity"
        tfItemQuantity.borderStyle = .roundedRect

        var orderFoundIndex: Int = -99
                
        let updateButton = UIButton(frame: CGRect(x: 16, y: 150, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Update Items", handler: { _ in
            
            // Item id
            guard let itemId = Int(tfItemId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
                return
            }
            var item: Item
            if let itemIndex = parent.items.firstIndex(where: {$0.id == itemId} ) {
                // from location valid
                item = parent.items[itemIndex]
            } else {
                self.showAlert(title: "Error", message: "Item does not exist")
                return
            }
            
            // Item quantity
            guard let quantity = Int(tfItemQuantity.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Quantity")
                return
            }
            
            let orderItem = OrderItem(item: item, quantity: quantity)
            let orderCost = self.getOrderTotal(items: [orderItem])
            parent.logisticsOrder[orderFoundIndex].itemsCarried = [orderItem]
            parent.logisticsOrder[orderFoundIndex].cost = orderCost
            self.showAlert(title: "Success", message: "Order items updated successfully")
        }))
        
        updateButton.isEnabled = false
        
        let fetchButton = UIButton(frame: CGRect(x: 160, y: 16, width: safeFrame.width - 200, height: 40), primaryAction: UIAction(title: "Fetch Order", handler: { _ in
            guard let orderId = Int(tfOrderId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Order Id")
                return
            }
            if let orderIndex = parent.logisticsOrder.firstIndex(where: {$0.id == orderId}) {
                orderFoundIndex = orderIndex
                tfOrderId.isEnabled = false
                let order = parent.logisticsOrder[orderIndex]
                tfItemId.text = "\(order.itemsCarried[0].item.id)"
                tfItemQuantity.text = "\(order.itemsCarried[0].quantity)"
                updateButton.isEnabled = true
            } else {
                self.showAlert(title: "Error", message: "Order id does not exist")
                return
            }
        }))
        
        updateButton.backgroundColor = .systemGreen
        fetchButton.backgroundColor = .systemBlue
        
        parent.outputView.addSubview(tfOrderId)
        parent.outputView.addSubview(fetchButton)
        parent.outputView.addSubview(tfItemId)
        parent.outputView.addSubview(tfItemQuantity)
        parent.outputView.addSubview(updateButton)

    }
    
    
    @objc func deleteOrder() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 40))
        label.text = "Enter the id of order to delete:"
        let textField = UITextField(frame: CGRect(x: 16, y: 72, width: safeFrame.width - 32, height: 40))
        textField.placeholder = "Enter the id of order to delete:"
        textField.borderStyle = .roundedRect
        
        let button = UIButton(frame: CGRect(x: 16, y: 120, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Delete", handler: { _ in
            let itemId = Int(textField.text ?? "0") ?? 0
            if let itemIndex = parent.logisticsOrder.firstIndex(where: {$0.id == itemId}) {
                parent.logisticsOrder.remove(at: itemIndex)
                self.showAlert(title: "Success", message: "Deleted successfully")
            } else {
                self.showAlert(title: "Error", message: "Invalid Order Id")
            }
        }))
        button.backgroundColor = .systemRed
        parent.outputView.addSubview(label)
        parent.outputView.addSubview(textField)
        parent.outputView.addSubview(button)
    }
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView(title: title,
                                    message: message,
                                    delegate: self,
                                    cancelButtonTitle: "Okay")
        alertView.show()
    }
    
    func validateDate(enteredDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if let validDate = dateFormatter.date(from: enteredDate) {
            return validDate
        }
        return nil
    }
    
    func getOrderTotal(items: [OrderItem]) -> Int {
        var total = 0
        for item in items {
            let val = item.quantity * item.item.value
            total += val
        }
        return total
    }
}
