//
//  CreateItemViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/5/22.
//

import UIKit

class CreateItemViewController: UIViewController {
    @IBOutlet weak var tfItemId: UITextField!
    @IBOutlet weak var tfItemName: UITextField!
    @IBOutlet weak var tfItemValue: UITextField!
    @IBOutlet weak var tfItemWeight: UITextField!
    @IBOutlet weak var tfItemDescription: UITextField!
    
    var mainVC: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnCreateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }

        guard let itemId = Int(tfItemId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Item Id")
            return
        }
        if let _ = mainVC.items.firstIndex(where: {$0.id == itemId}) {
            self.showAlert(title: "Error", message: "Item id already exists")
            return
        }
        
        guard let itemName = tfItemName.text else {
            self.showAlert(title: "Error", message: "Item name is empty")
            return
        }
        if itemName.isEmpty {
            self.showAlert(title: "Error", message: "Item name is empty")
            return
        }
        
        guard let itemDesc = tfItemDescription.text else {
            self.showAlert(title: "Error", message: "Item description is empty")
            return
        }
        
        guard let itemWeight = Int(tfItemWeight.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid weight")
            return
        }; if itemWeight <= 0 {
            showAlert(title: "Error", message: "Weight cannot be 0")
            return
        }
        
        guard let itemValue = Int(tfItemValue.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid value")
            return
        }; if itemValue <= 0 {
            showAlert(title: "Error", message: "Value cannot be 0")
            return
        }
        
        let item = Item(id: itemId, name: itemName, desc: itemDesc, weight: itemWeight, value: itemValue)
        
        //1 (Used for performance)
        mainVC.items.append(item)
        //Create record in the database
        DatabaseManager.shared.saveRecord(item: item)
        
        // 2 (Not used)
        //DatabaseManager.shared.saveRecord(item: item)
        //mainVC.items = DatabaseManager.shared.fetchRecords(type: Item.self)
        
        self.showAlert(title: "Success", message: "Item created successfully")
    }
    
    
    @IBAction func buttonCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView(title: title,
                                    message: message,
                                    delegate: self,
                                    cancelButtonTitle: "Okay")
        alertView.show()
    }
    
    @IBAction func doneId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneItem(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}
