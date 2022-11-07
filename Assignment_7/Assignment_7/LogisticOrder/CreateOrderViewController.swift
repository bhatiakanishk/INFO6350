//
//  CreateOrderViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class CreateOrderViewController: UIViewController {
    @IBOutlet weak var tfOrderId: UITextField!
    @IBOutlet weak var tfFromLocationId: UITextField!
    @IBOutlet weak var tfToLocationId: UITextField!
    @IBOutlet weak var tfArrivalDate: UITextField!
    @IBOutlet weak var tfDepartureDate: UITextField!
    @IBOutlet weak var tfItemId: UITextField!
    @IBOutlet weak var tfItemQuantity: UITextField!
    @IBOutlet weak var tfItemId2: UITextField!
    @IBOutlet weak var tfItemQuantity2: UITextField!
    @IBOutlet weak var tfItemId3: UITextField!
    @IBOutlet weak var tfItemQuantity3: UITextField!
    @IBOutlet weak var tfItemId4: UITextField!
    @IBOutlet weak var tfItemQuantity4: UITextField!
    
    
    var mainVC: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnCreateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        
        guard let orderId = Int(tfOrderId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Order Id")
            return
        }
        if let _ = mainVC.logisticsOrder.firstIndex(where: {$0.id == orderId}) {
            self.showAlert(title: "Error", message: "Order id already exists")
            return
        }
        
        // From Location
        guard let fromLocationId = Int(tfFromLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid From Location Id")
            return
        }
        var fromLocation: Location
        if let fromLocationIndex = mainVC.locations.firstIndex(where: {$0.id == fromLocationId} ) {
            // from location valid
            fromLocation = mainVC.locations[fromLocationIndex]
        } else {
            self.showAlert(title: "Error", message: "From Location does not exist")
            return
        }
        
        // To Location
        guard let toLocationId = Int(tfToLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid To Location Id")
            return
        }
        var toLocation: Location
        if let toLocationIndex = mainVC.locations.firstIndex(where: {$0.id == toLocationId} ) {
            // from location valid
            toLocation = mainVC.locations[toLocationIndex]
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
        if let itemIndex = mainVC.items.firstIndex(where: {$0.id == itemId} ) {
            // from location valid
            item = mainVC.items[itemIndex]
        } else {
            self.showAlert(title: "Error", message: "Item does not exist")
            return
        }
        
        // Item quantity
        guard let quantity = Int(tfItemQuantity.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Quantity")
            return
        }; if quantity <= 0 {
            showAlert(title: "Error", message: "Weight cannot be 0")
            return
        }
        
        let orderItems = [OrderItem(item: item, quantity: quantity)]
        let orderCost = self.getOrderTotal(items: orderItems)
        
        mainVC.logisticsOrder.append(LogisticsOrder(id: orderId, fromLocation: fromLocation, toLocation: toLocation, estimatedArrivalDate: arrivalDate, departureDate: departureDate, cost: orderCost, itemsCarried: orderItems))

        self.showAlert(title: "Success", message: "Order created successfully")

    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
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
    
    @IBAction func doneId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneFromId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneToId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneArrival(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneDeparture(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneItemId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneQuantity(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
