//
//  LocationDetailsViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    var mainVC: ViewController?
    var vcMode: ViewControllerMode = .create

    var indexPath: IndexPath?

    @IBOutlet weak var tfLocationId: UITextField!
    @IBOutlet weak var tfStreetName: UITextField!
    @IBOutlet weak var tfCityName: UITextField!
    @IBOutlet weak var tfStateName: UITextField!
    @IBOutlet weak var tfCountryName: UITextField!
    @IBOutlet weak var tfZipcode: UITextField!

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if vcMode == .modify {
            guard let mainVC = mainVC, let indexPath = indexPath else { return }
            
            title = "Update Location"
            let location = mainVC.locations[indexPath.row]
            button.setTitle("Update Location", for: .normal)
            
            tfLocationId.text = "\(location.id)"
            tfLocationId.isEnabled = false
            tfStreetName.text = location.street
            tfCityName.text = location.city
            tfStateName.text = location.state
            tfCountryName.text = location.country
            tfZipcode.text = location.zip
        } else {
            title = "Create Location"
            button.setTitle("Create Location", for: .normal)
        }
    }

    
    @IBAction func createButtonTapped(_ sender: Any) {
        if vcMode == .modify {
            updateLocation()
        } else {
            createLocation()
        }
    }
    
    func createLocation() {
        guard let mainVC = self.mainVC else { return }
        
        guard let locationId = Int(tfLocationId.text ?? "0") else {
            self.showAlert(title: "Error", message: "Invalid Location Id")
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
        
        let location = Location(id: locationId, street: streetName, city: cityName, state: stateName, country: country, zip: String(zipCode))
        mainVC.locations.append(location)
        
        //Create record in the database
        DatabaseManager.shared.saveRecord(item: location)
        self.showAlert(title: "Success", message: "Location created successfully")

    }
    
    func updateLocation() {
        guard let mainVC = mainVC, let indexPath = indexPath else { return }
        
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

        mainVC.locations[indexPath.row].street = streetName
        mainVC.locations[indexPath.row].city = cityName
        mainVC.locations[indexPath.row].state = stateName
        mainVC.locations[indexPath.row].country = country
        mainVC.locations[indexPath.row].zip = String(zipCode)

        let updatedLocation = mainVC.locations[indexPath.row]
        
        //Update record in the database
        DatabaseManager.shared.updateRecord(item: updatedLocation)
        
        self.showAlert(title: "Success", message: "Item updated successfully")
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
