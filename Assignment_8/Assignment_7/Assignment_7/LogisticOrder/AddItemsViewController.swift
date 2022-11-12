//
//  AddItemsViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class AddItemsViewController: UIViewController {

    @IBOutlet weak var tfOrderId: UITextField!
    @IBOutlet weak var tfItemId: UITextField!
    @IBOutlet weak var tfItemQuantity: UITextField!
    var orderFoundIndex: Int = -99
    var mainVC: MainViewController?
    
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

            //let order = mainVC.logisticsOrder[orderIndex]
            self.showAlert(title: "Success", message: "Order Found")
        } else {
            self.showAlert(title: "Error", message: "Order id does not exist")
            return
        }
    }
    
    @IBAction func btnAddTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
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
        
        let orderItem = OrderItem(item: item, quantity: quantity)
        let orderCost = self.getOrderTotal(items: [orderItem])
        mainVC.logisticsOrder[orderFoundIndex].itemsCarried.append(orderItem)
        mainVC.logisticsOrder[orderFoundIndex].cost += orderCost
        
        let updatedOrder = mainVC.logisticsOrder[orderFoundIndex]
        DatabaseManager.shared.updateRecord(item: updatedOrder)
        
        self.showAlert(title: "Success", message: "Order items updated successfully")
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
    
    func getOrderTotal(items: [OrderItem]) -> Int {
        var total = 0
        for item in items {
            let val = item.quantity * item.item.value
            total += val
        }
        return total
    }
}
