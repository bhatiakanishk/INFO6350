//
//  DeleteLocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class DeleteLocationViewController: UIViewController {
    
    @IBOutlet weak var tfLocationId: UITextField!
    var mainVC: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDeleteTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        
        let itemId = Int(tfLocationId.text ?? "0") ?? 0
        if let itemIndex = mainVC.locations.firstIndex(where: {$0.id == itemId}) {
            mainVC.locations.remove(at: itemIndex)
            
            //Delete record in the database
            DatabaseManager.shared.deleteRecord(type: Location.self, id: itemId)
            self.showAlert(title: "Success", message: "Deleted successfully")
        } else {
            self.showAlert(title: "Error", message: "Invalid Location Id")
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
}
