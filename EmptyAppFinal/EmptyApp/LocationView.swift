//
//  LocationView.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import UIKit

class LocationView: UIView {
    
    var safeFrame: CGRect
    var parent: MainView?
    
    init() {
        let windowSize = UIApplication.shared.windows[0]
        safeFrame = windowSize.safeAreaLayoutGuide.layoutFrame
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLocationMenu() -> UIView {
        let locationCreateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Create Location", for: .normal)
            button.frame = CGRect(x: 16, y: 0, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        locationCreateButton.addTarget(self, action: #selector(createLocation), for: .touchUpInside)
        
        let locationViewButton: UIButton = {
            let button = UIButton()
            button.setTitle("View Location", for: .normal)
            button.frame = CGRect(x: 16, y: 52, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        locationViewButton.addTarget(self, action: #selector(viewLocation), for: .touchUpInside)
        
        let locationUpdateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Update Location", for: .normal)
            button.frame = CGRect(x: 16, y: 104, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        locationUpdateButton.addTarget(self, action: #selector(updateLocation), for: .touchUpInside)
        
        let locationDeleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Delete Location", for: .normal)
            button.frame = CGRect(x: 16, y: 156, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        locationDeleteButton.addTarget(self, action: #selector(deleteLocation), for: .touchUpInside)
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: safeFrame.width, height: 200))
        view.addSubview(locationCreateButton)
        view.addSubview(locationViewButton)
        view.addSubview(locationUpdateButton)
        view.addSubview(locationDeleteButton)
        return view
    }
    
    @objc func createLocation() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfLocationId = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 24))
        tfLocationId.placeholder = "Enter location id:"
        tfLocationId.borderStyle = .roundedRect
        
        let tfStreetName = UITextField(frame: CGRect(x: 16, y: 48, width: safeFrame.width - 32, height: 24))
        tfStreetName.placeholder = "Enter street name:"
        tfStreetName.borderStyle = .roundedRect
        
        let tfCityName = UITextField(frame: CGRect(x: 16, y: 80, width: safeFrame.width - 32, height: 24))
        tfCityName.placeholder = "Enter city name:"
        tfCityName.borderStyle = .roundedRect
        
        let tfStateName = UITextField(frame: CGRect(x: 16, y: 112, width: safeFrame.width - 32, height: 24))
        tfStateName.placeholder = "Enter state name:"
        tfStateName.borderStyle = .roundedRect
        
        let tfCountryName = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfCountryName.placeholder = "Enter country:"
        tfCountryName.borderStyle = .roundedRect
        
        let tfZipCode = UITextField(frame: CGRect(x: 16, y: 176, width: safeFrame.width - 32, height: 24))
        tfZipCode.placeholder = "Enter zip code:"
        tfZipCode.borderStyle = .roundedRect
        
        let button = UIButton(frame: CGRect(x: 16, y: 208, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Create Location", handler: { _ in
            
            // Location Id
            guard let locationId = Int(tfLocationId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
                return
            }
            if let _ = parent.locations.firstIndex(where: {$0.id == locationId}) {
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
            
            guard let zipCode = Int(tfZipCode.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid zipcode")
                return
            }
            
            parent.locations.append(Location(id: locationId, street: streetName, city: cityName, state: stateName, country: country, zip: zipCode))
            self.showAlert(title: "Success", message: "Location created successfully")
        }))
        
        button.backgroundColor = .systemGreen
        
        parent.outputView.addSubview(tfLocationId)
        parent.outputView.addSubview(tfStreetName)
        parent.outputView.addSubview(tfCityName)
        parent.outputView.addSubview(tfStateName)
        parent.outputView.addSubview(tfCountryName)
        parent.outputView.addSubview(tfZipCode)
        parent.outputView.addSubview(button)
    }

    
    @objc func viewLocation() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        let textView = UITextView(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: parent.outputView.frame.height - 32))
        var outputStr = ""
        for item in parent.locations {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No locations exist" : outputStr
        parent.outputView.addSubview(textView)
    }
    
    
    @objc func updateLocation() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfLocationId = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 24))
        tfLocationId.placeholder = "Enter location id:"
        tfLocationId.borderStyle = .roundedRect
        
        let tfStreetName = UITextField(frame: CGRect(x: 16, y: 48, width: safeFrame.width - 32, height: 24))
        tfStreetName.placeholder = "Enter street name:"
        tfStreetName.borderStyle = .roundedRect
        
        let tfCityName = UITextField(frame: CGRect(x: 16, y: 80, width: safeFrame.width - 32, height: 24))
        tfCityName.placeholder = "Enter city name:"
        tfCityName.borderStyle = .roundedRect
        
        let tfStateName = UITextField(frame: CGRect(x: 16, y: 112, width: safeFrame.width - 32, height: 24))
        tfStateName.placeholder = "Enter state name:"
        tfStateName.borderStyle = .roundedRect
        
        let tfCountryName = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfCountryName.placeholder = "Enter country:"
        tfCountryName.borderStyle = .roundedRect
        
        let tfZipCode = UITextField(frame: CGRect(x: 16, y: 176, width: safeFrame.width - 32, height: 24))
        tfZipCode.placeholder = "Enter zip code:"
        tfZipCode.borderStyle = .roundedRect

        var locationFoundIndex: Int = -99
                
        let updateButton = UIButton(frame: CGRect(x: 16, y: 180, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Update Item", handler: { _ in
            
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
            
            guard let zipCode = Int(tfZipCode.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid zipcode")
                return
            }

            parent.locations[locationFoundIndex].street = streetName
            parent.locations[locationFoundIndex].city = cityName
            parent.locations[locationFoundIndex].state = stateName
            parent.locations[locationFoundIndex].country = country
            parent.locations[locationFoundIndex].zip = zipCode

            self.showAlert(title: "Success", message: "Item updated successfully")
        }))
        
        updateButton.isEnabled = false
        
        let fetchButton = UIButton(frame: CGRect(x: 160, y: 16, width: safeFrame.width - 200, height: 40), primaryAction: UIAction(title: "Fetch Item", handler: { _ in
            guard let locationId = Int(tfLocationId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Location Id")
                return
            }
            if let locationIndex = parent.locations.firstIndex(where: {$0.id == locationId}) {
                locationFoundIndex = locationIndex
                tfLocationId.isEnabled = false
                let location = parent.locations[locationIndex]
                
                tfStreetName.text = location.street
                tfCityName.text = location.city
                tfStateName.text = location.state
                tfCountryName.text = location.country
                tfZipCode.text = "\(location.zip)"

                updateButton.isEnabled = true
            } else {
                self.showAlert(title: "Error", message: "Location id does not exist")
                return
            }
        }))

        
        updateButton.backgroundColor = .systemGreen
        fetchButton.backgroundColor = .systemBlue
        
        parent.outputView.addSubview(tfLocationId)
        parent.outputView.addSubview(fetchButton)
        parent.outputView.addSubview(tfStreetName)
        parent.outputView.addSubview(tfCityName)
        parent.outputView.addSubview(tfStateName)
        parent.outputView.addSubview(tfCountryName)
        parent.outputView.addSubview(tfZipCode)
        parent.outputView.addSubview(updateButton)
    }
    
    @objc func deleteLocation() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 40))
        label.text = "Enter the id of location to delete:"
        let textField = UITextField(frame: CGRect(x: 16, y: 72, width: safeFrame.width - 32, height: 40))
        textField.placeholder = "Enter the id of location to delete:"
        textField.borderStyle = .roundedRect
        
        let button = UIButton(frame: CGRect(x: 16, y: 120, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Delete", handler: { _ in
            let itemId = Int(textField.text ?? "0") ?? 0
            if let itemIndex = parent.locations.firstIndex(where: {$0.id == itemId}) {
                parent.locations.remove(at: itemIndex)
                self.showAlert(title: "Success", message: "Deleted successfully")
            } else {
                self.showAlert(title: "Error", message: "Invalid Location Id")
            }
        }))
        button.backgroundColor = .systemRed
        parent.outputView.addSubview(label)
        parent.outputView.addSubview(textField)
        parent.outputView.addSubview(button)
    }
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView(title: title,
                                    message: message,
                                    delegate: self,
                                    cancelButtonTitle: "Okay")
        alertView.show()
    }
}
