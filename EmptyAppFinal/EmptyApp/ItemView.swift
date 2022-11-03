//
//  ItemView.swift
//  EmptyApp
//
//  Created by Kanishk Bhatia on 10/30/22.
//  Copyright © 2022 rab. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
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
    
    func getItemsMenu() -> UIView {
        let itemCreateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Create Items", for: .normal)
            button.frame = CGRect(x: 16, y: 0, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        itemCreateButton.addTarget(self, action: #selector(createItem), for: .touchUpInside)
        
        let itemViewButton: UIButton = {
            let button = UIButton()
            button.setTitle("View Items", for: .normal)
            button.frame = CGRect(x: 16, y: 52, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        itemViewButton.addTarget(self, action: #selector(viewItem), for: .touchUpInside)
        
        let itemUpdateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Update Items", for: .normal)
            button.frame = CGRect(x: 16, y: 104, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        itemUpdateButton.addTarget(self, action: #selector(updateItem), for: .touchUpInside)

        
        let itemDeleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Delete Items", for: .normal)
            button.frame = CGRect(x: 16, y: 156, width: 160, height: 44)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            return button
        }()
        itemDeleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: safeFrame.width, height: 200))
        view.addSubview(itemCreateButton)
        view.addSubview(itemViewButton)
        view.addSubview(itemUpdateButton)
        view.addSubview(itemDeleteButton)
        return view
    }
    
    @objc func createItem() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfItemId = UITextField(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 24))
        tfItemId.placeholder = "Enter item id:"
        tfItemId.borderStyle = .roundedRect
        
        let tfItemName = UITextField(frame: CGRect(x: 16, y: 48, width: safeFrame.width - 32, height: 24))
        tfItemName.placeholder = "Enter item name:"
        tfItemName.borderStyle = .roundedRect
        
        let tfDescription = UITextField(frame: CGRect(x: 16, y: 80, width: safeFrame.width - 32, height: 24))
        tfDescription.placeholder = "Enter item description:"
        tfDescription.borderStyle = .roundedRect
        
        let tfWeight = UITextField(frame: CGRect(x: 16, y: 112, width: safeFrame.width - 32, height: 24))
        tfWeight.placeholder = "Enter item weight:"
        tfWeight.borderStyle = .roundedRect
        
        let tfValue = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfValue.placeholder = "Enter item value:"
        tfValue.borderStyle = .roundedRect
        
        
        let button = UIButton(frame: CGRect(x: 16, y: 180, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Create Item", handler: { _ in
            
            guard let itemId = Int(tfItemId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
                return
            }
            if let _ = parent.items.firstIndex(where: {$0.id == itemId}) {
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
            
            guard let itemDesc = tfDescription.text else {
                self.showAlert(title: "Error", message: "Item description is empty")
                return
            }
            
            guard let itemWeight = Int(tfWeight.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid weight")
                return
            }
            
            guard let itemValue = Int(tfValue.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid value")
                return
            }
            
            parent.items.append(Item(id: itemId, name: itemName, desc: itemDesc, weight: itemWeight, value: itemValue))
            self.showAlert(title: "Success", message: "Item created successfully")
        }))
        
        button.backgroundColor = .systemGreen
        
        parent.outputView.addSubview(tfItemId)
        parent.outputView.addSubview(tfItemName)
        parent.outputView.addSubview(tfDescription)
        parent.outputView.addSubview(tfWeight)
        parent.outputView.addSubview(tfValue)
        parent.outputView.addSubview(button)
    }
    
    @objc func viewItem() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let textView = UITextView(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: parent.outputView.frame.height - 32))
        var outputStr = ""
        for item in parent.items {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No items exist" : outputStr
        parent.outputView.addSubview(textView)
    }
    
    @objc func updateItem() {
        
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let tfItemId = UITextField(frame: CGRect(x: 16, y: 16, width: 120, height: 24))
        tfItemId.placeholder = "Enter item id:"
        tfItemId.borderStyle = .roundedRect
        
        let tfItemName = UITextField(frame: CGRect(x: 16, y: 48, width: safeFrame.width - 32, height: 24))
        tfItemName.placeholder = "Enter item name:"
        tfItemName.borderStyle = .roundedRect
        
        let tfDescription = UITextField(frame: CGRect(x: 16, y: 80, width: safeFrame.width - 32, height: 24))
        tfDescription.placeholder = "Enter item description:"
        tfDescription.borderStyle = .roundedRect
        
        let tfWeight = UITextField(frame: CGRect(x: 16, y: 112, width: safeFrame.width - 32, height: 24))
        tfWeight.placeholder = "Enter item weight:"
        tfWeight.borderStyle = .roundedRect
        
        let tfValue = UITextField(frame: CGRect(x: 16, y: 144, width: safeFrame.width - 32, height: 24))
        tfValue.placeholder = "Enter item value:"
        tfValue.borderStyle = .roundedRect
        
        var itemFoundIndex: Int = -99
                
        let updateButton = UIButton(frame: CGRect(x: 16, y: 180, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Update Item", handler: { _ in
                        
            guard let itemName = tfItemName.text else {
                self.showAlert(title: "Error", message: "Item name is empty")
                return
            }
            if itemName.isEmpty {
                self.showAlert(title: "Error", message: "Item name is empty")
                return
            }
            
            guard let itemDesc = tfDescription.text else {
                self.showAlert(title: "Error", message: "Item description is empty")
                return
            }
            
            guard let itemWeight = Int(tfWeight.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid weight")
                return
            }
            
            guard let itemValue = Int(tfValue.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid value")
                return
            }
            
            parent.items[itemFoundIndex].name = itemName
            parent.items[itemFoundIndex].desc = itemDesc
            parent.items[itemFoundIndex].weight = itemWeight
            parent.items[itemFoundIndex].value = itemValue

            self.showAlert(title: "Success", message: "Item updated successfully")
        }))
        
        updateButton.isEnabled = false
        
        let fetchButton = UIButton(frame: CGRect(x: 160, y: 16, width: safeFrame.width - 200, height: 40), primaryAction: UIAction(title: "Fetch Item", handler: { _ in
            guard let itemId = Int(tfItemId.text ?? "0") else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
                return
            }
            if let itemIndex = parent.items.firstIndex(where: {$0.id == itemId}) {
                itemFoundIndex = itemIndex
                tfItemId.isEnabled = false
                let item = parent.items[itemIndex]
                tfItemName.text = item.name
                tfDescription.text = item.desc
                tfWeight.text = "\(item.weight)"
                tfValue.text = "\(item.value)"
                updateButton.isEnabled = true
            } else {
                self.showAlert(title: "Error", message: "Item id does not exist")
                return
            }
        }))
        
        updateButton.backgroundColor = .systemGreen
        fetchButton.backgroundColor = .systemBlue
        
        parent.outputView.addSubview(tfItemId)
        parent.outputView.addSubview(fetchButton)
        parent.outputView.addSubview(tfItemName)
        parent.outputView.addSubview(tfDescription)
        parent.outputView.addSubview(tfWeight)
        parent.outputView.addSubview(tfValue)
        parent.outputView.addSubview(updateButton)
    }
    
    
    @objc func deleteItem() {
        guard let parent = self.parent else { return }
        parent.outputView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: safeFrame.width - 32, height: 40))
        label.text = "Enter the id of item to delete:"
        let textField = UITextField(frame: CGRect(x: 16, y: 72, width: safeFrame.width - 32, height: 40))
        textField.placeholder = "Enter the id of item to delete:"
        textField.borderStyle = .roundedRect
        
        let button = UIButton(frame: CGRect(x: 16, y: 120, width: safeFrame.width - 32, height: 40), primaryAction: UIAction(title: "Delete", handler: { _ in
            let itemId = Int(textField.text ?? "0") ?? 0
            if let itemIndex = parent.items.firstIndex(where: {$0.id == itemId}) {
                parent.items.remove(at: itemIndex)
                self.showAlert(title: "Success", message: "Delete successfully")
            } else {
                self.showAlert(title: "Error", message: "Invalid Item Id")
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
