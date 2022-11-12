//
//  UpdateLocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class UpdateLocationViewController: UIViewController {
    
    var mainVC: MainViewController?
    var locationFoundIndex: Int = -99
    @IBOutlet weak var tfLocationId: UITextField!
    @IBOutlet weak var tfStreetName: UITextField!
    @IBOutlet weak var tfCityName: UITextField!
    @IBOutlet weak var tfStateName: UITextField!
    @IBOutlet weak var tfCountryName: UITextField!
    @IBOutlet weak var tfZipcode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFetchTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
        guard let locationId = Int(tfLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Location Id")
            return
        }
        if let locationIndex = mainVC.locations.firstIndex(where: {$0.id == locationId}) {
            let location = mainVC.locations[locationIndex]
            locationFoundIndex = locationIndex
            tfStreetName.text = location.street
            tfCityName.text = location.city
            tfStateName.text = location.state
            tfCountryName.text = location.country
            tfZipcode.text = "\(location.zip)"
        } else {
            self.showAlert(title: "Error", message: "Location id does not exist")
            return
        }
    }
    
    
    @IBAction func btnUpdateTap(_ sender: Any) {
        guard let mainVC = self.mainVC else { return }
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

        mainVC.locations[locationFoundIndex].street = streetName
        mainVC.locations[locationFoundIndex].city = cityName
        mainVC.locations[locationFoundIndex].state = stateName
        mainVC.locations[locationFoundIndex].country = country
        mainVC.locations[locationFoundIndex].zip = zipCode

        let updatedLocation = mainVC.locations[locationFoundIndex]
        DatabaseManager.shared.updateRecord(item: updatedLocation)
        
        self.showAlert(title: "Success", message: "Item updated successfully")
        tfStreetName.text = ""
        tfCityName.text = ""
        tfStateName.text = ""
        tfCountryName.text = ""
        tfZipcode.text = ""
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
    
    @IBAction func doneStreet(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneCity(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneState(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneCountry(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneZipcode(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}
