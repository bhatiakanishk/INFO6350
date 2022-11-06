//
//  UpdateDepartureDateViewController.swift
//  Assignment_7
//
//  Created by Raj Kalpesh Mehta on 11/6/22.
//

import UIKit

class UpdateDepartureDateViewController: UIViewController {

    @IBOutlet weak var tfOrderId: UITextField!
    @IBOutlet weak var tfDepartureDate: UITextField!
    var mainVC: MainViewController?
    var orderFoundIndex: Int = -99
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFetchTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        guard let orderId = Int(tfOrderId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Order Id")
            return
        }
        if let orderIndex = mainVC.logisticsOrder.firstIndex(where: {$0.id == orderId}) {
            orderFoundIndex = orderIndex

            let order = mainVC.logisticsOrder[orderIndex]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            tfDepartureDate.text = dateFormatter.string(from: order.departureDate)

        } else {
            self.showAlert(title: "Error", message: "Order id does not exist")
            return
        }
    }
    
    @IBAction func btnUpdateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        
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

        mainVC.logisticsOrder[orderFoundIndex].departureDate = departureDate
        self.showAlert(title: "Success", message: "Order departure date updated successfully")
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
