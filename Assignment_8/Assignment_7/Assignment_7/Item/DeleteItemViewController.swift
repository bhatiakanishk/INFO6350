//
//  DeleteItemViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/5/22.
//

import UIKit

class DeleteItemViewController: UIViewController {

    var mainVC: MainViewController?

    @IBOutlet weak var tfItemId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnDeleteTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }

        let itemId = Int(tfItemId.text ?? "0") ?? 0
        if let itemIndex = mainVC.items.firstIndex(where: {$0.id == itemId}) {
            mainVC.items.remove(at: itemIndex)
            
            //Create record in the database
            DatabaseManager.shared.deleteRecord(type: Item.self, id: itemId)
            self.showAlert(title: "Success", message: "Delete successfully")
        } else {
            self.showAlert(title: "Error", message: "Invalid Item Id")
        }
    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        self.dismiss(animated: true)
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
}
