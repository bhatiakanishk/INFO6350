//
//  ItemDetailsViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    var mainVC: ViewController?
    var vcMode: ViewControllerMode = .create
        
    var indexPath: IndexPath?
    
    @IBOutlet weak var tfItemId: UITextField!
    @IBOutlet weak var tfItemName: UITextField!
    @IBOutlet weak var tfItemValue: UITextField!
    @IBOutlet weak var tfItemWeight: UITextField!
    @IBOutlet weak var tfItemDescription: UITextField!

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if vcMode == .modify {
            guard let mainVC = mainVC, let indexPath = indexPath else { return }
            title = "Update Item"
            let item = mainVC.items[indexPath.row]
            button.setTitle("Update Item", for: .normal)
            tfItemId.text = "\(item.id)"
            tfItemId.isEnabled = false
            tfItemName.text = item.name
            tfItemValue.text = "\(item.value)"
            tfItemWeight.text = "\(item.weight)"
            tfItemDescription.text = item.desc
            if let imageData = item.imageData {
                imageView.image = UIImage(data: imageData)
            } else {
                imageView.image = UIImage(named: "placeholder")
            }
        } else {
            title = "Create Item"
            button.setTitle("Create Item", for: .normal)
        }
    }

    @IBAction func selectNewImageTap(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func createButtonTap(_ sender: Any) {
        if vcMode == .modify {
            updateItem()
        } else {
            createItem()
        }
    }
    
    func createItem() {
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
        
        let item = Item(imageData: imageView.image?.pngData(), id: itemId, name: itemName, desc: itemDesc, weight: itemWeight, value: itemValue)
        
        //1 (Used for performance)
//        mainVC.items.append(item)
        //Create record in the database
//        DatabaseManager.shared.saveRecord(item: item)
        
        // 2 (Not used)
        //DatabaseManager.shared.saveRecord(item: item)
        //mainVC.items = DatabaseManager.shared.fetchRecords(type: Item.self)
        
//        self.showAlert(title: "Success", message: "Item created successfully")
        
        
        
        APIUtils.shared.postItem(item: item) {
            DispatchQueue.main.async {
                mainVC.items.append(item)
                DatabaseManager.shared.saveRecord(item: item)
                self.showAlert(title: "Success", message: "Item created successfully")
            }
        }

        

    }
    
    func updateItem() {
        guard let mainVC = mainVC, let indexPath = indexPath else { return }

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
        
        mainVC.items[indexPath.row].imageData = imageView.image?.pngData()
        mainVC.items[indexPath.row].name = itemName
        mainVC.items[indexPath.row].desc = itemDesc
        mainVC.items[indexPath.row].weight = itemWeight
        mainVC.items[indexPath.row].value = itemValue
        
        let updatedItem = mainVC.items[indexPath.row]
        
        //Update record in the database
        DatabaseManager.shared.updateRecord(item: updatedItem)
        
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



extension ItemDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
