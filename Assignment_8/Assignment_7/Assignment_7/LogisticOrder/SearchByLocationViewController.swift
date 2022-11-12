//
//  SearchByLocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class SearchByLocationViewController: UIViewController {

    @IBOutlet weak var tfLocationId: UITextField!
    @IBOutlet weak var textField: UITextView!
    var mainVC: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSearchTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        guard let location = Int(tfLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Location Id")
            return
        }
        
        let orders = mainVC.logisticsOrder.filter( {$0.toLocation.id == location || $0.fromLocation.id == location} )
        if orders.count > 0 {
            var outputStr = ""
            for order in orders {
                outputStr.append(order.getDescription())
                outputStr.append("\n")
            }
            textField.text = outputStr
        } else {
            textField.text = "No orders found"
        }
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
}
