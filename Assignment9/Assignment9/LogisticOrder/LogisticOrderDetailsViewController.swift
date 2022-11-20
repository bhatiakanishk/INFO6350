//
//  LogisticOrderDetailsViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class LogisticOrderDetailsViewController: UIViewController {
    
    var mainVC: ViewController?
    var vcMode: ViewControllerMode = .create
    
    var indexPath: IndexPath?
    var existingOrder: LogisticsOrder?
    var tempSelectedOrderItems: OrderItems = OrderItems()
    
    @IBOutlet weak var tfOrderId: UITextField!
    @IBOutlet weak var fromLocationPicker: UIPickerView!
    @IBOutlet weak var toLocationPicker: UIPickerView!
    @IBOutlet weak var arrivalDatePicker: UIDatePicker!
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var orderItemsTableView: UITableView!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromLocationPicker.dataSource = self
        fromLocationPicker.delegate = self
        toLocationPicker.dataSource = self
        toLocationPicker.delegate = self
        
        orderItemsTableView.dataSource = self
        orderItemsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if vcMode == .modify {
            guard let mainVC = mainVC, let indexPath = indexPath else { return }
            title = "Update Logistic Order"
            button.setTitle("Update Order", for: .normal)

            existingOrder = mainVC.logisticsOrder[indexPath.row]
            guard let existingOrder = existingOrder else { return }
            
            tfOrderId.text = "\(existingOrder.id)"
            tfOrderId.isEnabled = false
            departureDatePicker.setDate(existingOrder.departureDate, animated: true)
            arrivalDatePicker.setDate(existingOrder.estimatedArrivalDate, animated: true)
            tempSelectedOrderItems = OrderItems(items: existingOrder.itemsCarried)
            
            fromLocationPicker.isUserInteractionEnabled = false
            toLocationPicker.isUserInteractionEnabled = false
            
            orderTotalLabel.text = "Total: \(tempSelectedOrderItems.orderTotal)"
            
            if let fromLocationPosition = mainVC.locations.firstIndex(where: { $0.id == existingOrder.fromLocation.id }) {
                fromLocationPicker.selectRow(fromLocationPosition, inComponent: 0, animated: true)
            }
            if let toLocationPosition = mainVC.locations.firstIndex(where: { $0.id == existingOrder.toLocation.id }) {
                toLocationPicker.selectRow(toLocationPosition, inComponent: 0, animated: true)
            }
            
        } else {
            title = "Create Order"
            button.setTitle("Create Order", for: .normal)
        }
    }

    @IBAction func createButtonTapped(_ sender: Any) {
        if vcMode == .create {
            createOrder()
        } else {
            updateOrder()
        }
    }
    
    func createOrder() {
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
        let fromLocation: Location = mainVC.locations[fromLocationPicker.selectedRow(inComponent: 0)]
        
        // To Location
        let toLocation: Location = mainVC.locations[toLocationPicker.selectedRow(inComponent: 0)]
        
        // Arrival Date
        let arrivalDate = arrivalDatePicker.date
        
        // Departure Date
        let departureDate = departureDatePicker.date
    
        if arrivalDate < departureDate {
            self.showAlert(title: "Error", message: "Arrival date cannot be before departure date")
            return
        }
        
        if tempSelectedOrderItems.items.count == 0 {
            self.showAlert(title: "Error", message: "Select atleast one item")
            return
        }
        
        let orderCost = tempSelectedOrderItems.orderTotal
        
        let order = LogisticsOrder(id: orderId, fromLocation: fromLocation, toLocation: toLocation, departureDate: departureDate, estimatedArrivalDate: arrivalDate, cost: orderCost, itemsCarried: tempSelectedOrderItems.items)
        mainVC.logisticsOrder.append(order)
        //Creating new record in the database
        DatabaseManager.shared.saveRecord(item: order)

        self.showAlert(title: "Success", message: "Order created successfully")
    }
    
    func updateOrder() {
        guard let mainVC = mainVC, let indexPath = indexPath else { return }
                
        // Arrival Date
        let arrivalDate = arrivalDatePicker.date
        
        // Departure Date
        let departureDate = departureDatePicker.date
    
        if arrivalDate < departureDate {
            self.showAlert(title: "Error", message: "Arrival date cannot be before departure date")
            return
        }
        
        if tempSelectedOrderItems.items.count == 0 {
            self.showAlert(title: "Error", message: "Select atleast one item")
            return
        }
        
        let orderCost = tempSelectedOrderItems.orderTotal
                
        mainVC.logisticsOrder[indexPath.row].estimatedArrivalDate = arrivalDate
        mainVC.logisticsOrder[indexPath.row].departureDate = departureDate
        mainVC.logisticsOrder[indexPath.row].cost = orderCost
        mainVC.logisticsOrder[indexPath.row].itemsCarried = tempSelectedOrderItems.items

        let updatedOrder = mainVC.logisticsOrder[indexPath.row]
        
        //Update record in the database
        DatabaseManager.shared.updateRecord(item: updatedOrder)
        DispatchQueue.main.async {
            self.orderTotalLabel.text = "Total: \(self.tempSelectedOrderItems.orderTotal)"
        }

        self.showAlert(title: "Success", message: "Order updated successfully")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension LogisticOrderDetailsViewController: UIPickerViewDelegate {
    
}

extension LogisticOrderDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let mainVC = mainVC else { return 0 }
        return mainVC.locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let mainVC = mainVC else { return "" }
        let location = mainVC.locations[row]
        return "\(location.street), \(location.city), \(location.state)"
    }
}


extension LogisticOrderDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainVC = mainVC else { return 0 }
        return mainVC.items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mainVC = mainVC,
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderItemsCell") as? OrderItemsTableViewCell {
            let item = mainVC.items[indexPath.row]
            cell.tempSelectedOrderItems = tempSelectedOrderItems
            cell.item = item
            
            
            if let tempSelectedOrderItem = tempSelectedOrderItems.items.first(where: { $0.item.id == item.id }) {
                cell.quantity = tempSelectedOrderItem.quantity
                cell.quantityLabel.text = "\(cell.quantity)"
            }

            cell.nameLabel.text = item.name
            
            if let imageData = item.imageData {
                cell.iconView.image = UIImage(data: imageData)
            } else {
                cell.iconView.image = UIImage(named: "placeholder")
            }
            cell.iconView.contentMode = .scaleAspectFit
            return cell
        }
        return UITableViewCell()
    }
}

extension LogisticOrderDetailsViewController: UITableViewDelegate {
    
}
