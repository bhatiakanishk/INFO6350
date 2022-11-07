//
//  UpdateItemViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class UpdateItemViewController: UIViewController {
    
    var mainVC: MainViewController?
    var itemFoundIndex: Int = -99
    @IBOutlet weak var tfItemId: UITextField!
    @IBOutlet weak var tfItemName: UITextField!
    @IBOutlet weak var tfItemValue: UITextField!
    @IBOutlet weak var tfItemWeight: UITextField!
    @IBOutlet weak var tfItemDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnFetchTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        guard let itemId = Int(tfItemId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Item Id")
            return
        }
        if let itemIndex = mainVC.items.firstIndex(where: {$0.id == itemId}) {
            itemFoundIndex = itemIndex
            let item = mainVC.items[itemIndex]
            tfItemName.text = item.name
            tfItemDescription.text = item.desc
            tfItemWeight.text = "\(item.weight)"
            tfItemValue.text = "\(item.value)"
        } else {
            self.showAlert(title: "Error", message: "Item id does not exist")
            return
        }
    }
    
    @IBAction func btnUpdateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
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
            showAlert(title: "Error", message: "Weight cannot be 0")
            return
        }
        
        
        mainVC.items[itemFoundIndex].name = itemName
        mainVC.items[itemFoundIndex].desc = itemDesc
        mainVC.items[itemFoundIndex].weight = itemWeight
        mainVC.items[itemFoundIndex].value = itemValue
        
        self.showAlert(title: "Success", message: "Item updated successfully")
        tfItemId.text = ""
        tfItemName.text = ""
        tfItemDescription.text = ""
        tfItemWeight.text = ""
        tfItemValue.text = ""
        
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
    
    @IBAction func doneId(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func doneName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneValue(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneWeight(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneDesc(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
