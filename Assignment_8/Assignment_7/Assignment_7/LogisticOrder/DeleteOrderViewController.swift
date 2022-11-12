//
//  DeleteOrderViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatiaon 11/6/22.
//

import UIKit

class DeleteOrderViewController: UIViewController {

    @IBOutlet weak var tfOrderId: UITextField!
    var mainVC: MainViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnDeleteTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        let itemId = Int(tfOrderId.text ?? "0") ?? 0
        if let itemIndex = mainVC.logisticsOrder.firstIndex(where: {$0.id == itemId}) {
            mainVC.logisticsOrder.remove(at: itemIndex)
            DatabaseManager.shared.deleteRecord(type: LogisticsOrder.self, id: itemId)
            self.showAlert(title: "Success", message: "Deleted successfully")
        } else {
            self.showAlert(title: "Error", message: "Invalid Order Id")
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
