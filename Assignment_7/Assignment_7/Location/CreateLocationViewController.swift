//
//  CreateLocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class CreateLocationViewController: UIViewController {

    var mainVC: MainViewController?
    
    @IBOutlet weak var tfStreetName: UITextField!
    @IBOutlet weak var tfLocationId: UITextField!
    @IBOutlet weak var tfCityName: UITextField!
    @IBOutlet weak var tfStateName: UITextField!
    @IBOutlet weak var tfCountryName: UITextField!
    @IBOutlet weak var tfZipcode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCreateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        
        guard let locationId = Int(tfLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Item Id")
            return
        }
        if let _ = mainVC.locations.firstIndex(where: {$0.id == locationId}) {
            self.showAlert(title: "Error", message: "Location id already exists")
            return
        }
        
        // Street
        guard let streetName = tfStreetName.text else {
            self.showAlert(title: "Error", message: "Street name is empty")
            return
        }
        if streetName.isEmpty {
            self.showAlert(title: "Error", message: "Street name is empty")
            return
        }
        
        // City
        guard let cityName = tfCityName.text else {
            self.showAlert(title: "Error", message: "City name is empty")
            return
        }
        if cityName.isEmpty {
            self.showAlert(title: "Error", message: "City name is empty")
            return
        }
        
        // State
        guard let stateName = tfStateName.text else {
            self.showAlert(title: "Error", message: "State name is empty")
            return
        }
        if stateName.isEmpty {
            self.showAlert(title: "Error", message: "State name is empty")
            return
        }
        
        // Country
        guard let country = tfCountryName.text else {
            self.showAlert(title: "Error", message: "Country name is empty")
            return
        }
        if country.isEmpty {
            self.showAlert(title: "Error", message: "Country name is empty")
            return
        }
        
        guard let zipCode = Int(tfZipcode.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid zipcode")
            return
        }
        
        mainVC.locations.append(Location(id: locationId, street: streetName, city: cityName, state: stateName, country: country, zip: zipCode))
        self.showAlert(title: "Success", message: "Location created successfully")
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
