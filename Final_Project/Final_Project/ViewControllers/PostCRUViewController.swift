//
//  PostCRUViewController.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/14/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostCRUViewController: UIViewController, UITextFieldDelegate {

    var post: Post?
    var db = Firestore.firestore()
    var user = Auth.auth().currentUser
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var descriptionTf: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    func clearError() {
        errorLabel.text = "error"
        errorLabel.alpha = 0
    }

    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func validateFields() -> String? {
        if Utilities.textInput(titleLabel.text!) == "" ||
            Utilities.textInput(descriptionTf.text!) == "" {
            return "Please enter all details."
        }
        return nil
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            self.showError(error!)
        } else {
            let title = Utilities.textInput(titleTf.text!)
            let body = Utilities.textInput(descriptionTf.text!)
            
            var alertMessage: String = ""
            
            if post != nil {
                db.collection("posts").document((post?.id)!).updateData([
                    "title": title,
                    "body": body,
                    "lastUpdated": FieldValue.serverTimestamp()
                ]) { err in
                    if let err = err {
                        self.showError("error saving data")
                    }
                }
                
                alertMessage = "Post updated successfully"
            } else {
                db.collection("users").whereField("uid", isEqualTo: user?.uid).getDocuments() {(querySnapshot, err) in
                    if let error = err {
                        print(error)
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        self.showError("error saving data")
                        return
                    }
                    
                    let dbUser = documents.compactMap { queryDocumentSnapshot -> User? in
                        return try? queryDocumentSnapshot.data(as: User.self)
                    }[0]
                    
                    let newPost = Post(title: title, body: body, createdById: (self.user?.uid)!, createdByName: "\(dbUser.firstName) \(dbUser.lastName)") //Check for timr
                    
                    do {
                        let _ = try self.db.collection("posts").addDocument(from: newPost)
                    } catch {
                        self.showError("error creating post")
                    }
                }
                
                alertMessage = "Post created successfully"
            }
            
            let alert = UIAlertController(title: "Message", message: alertMessage, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            })
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
