//
//  RegisterViewController.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/14/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTf.delegate = self
        lastNameTf.delegate = self
        emailTf.delegate = self
        passwordTf.delegate = self
        confirmPasswordTf.delegate = self
        
        clearError()

        // Do any additional setup after loading the view.
    }
    
    func clearError() {
        errorLabel.text = "error"
        errorLabel.alpha = 0
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func resetFields() {
        firstNameTf.text = ""
        lastNameTf.text = ""
        emailTf.text = ""
        passwordTf.text = ""
        confirmPasswordTf.text = ""
    }

    func textFieldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func validateFields() -> String? {
        if Utilities.textInput(firstNameTf.text!) == "" ||
            Utilities.textInput(lastNameTf.text!) == "" ||
            Utilities.textInput(emailTf.text!) == "" ||
            Utilities.textInput(passwordTf.text!) == "" ||
            Utilities.textInput(confirmPasswordTf.text!) == "" {
            return "Please enter all details"
        }
        
        let emailInput = Utilities.textInput(emailTf.text!)
        
        if Utilities.emailValid(emailInput) == false {
            return "Invalid email address"
        }
        
        let cleanedPassword = Utilities.textInput(passwordTf.text!)
        
        let cleanedConfirmPassword = Utilities.textInput(confirmPasswordTf.text!)
        
        if cleanedPassword != cleanedConfirmPassword {
            return "Password does not match."
        }
        if Utilities.passwordValid(cleanedPassword) == false {
            return "Password must be min 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            let firstName = Utilities.textInput(firstNameTf.text!)
            let lastName = Utilities.textInput(lastNameTf.text!)
            let email = Utilities.textInput(emailTf.text!)
            let password = Utilities.textInput(passwordTf.text!)
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (result,err) in
                if err != nil {
                    switch AuthErrorCode(rawValue: err!._code) {
                        case .emailAlreadyInUse : self.showError("Email already registered")
                        default: self.showError("error creating user")
                    }
                } else {
                    let newUser = User(userId: (result?.user.uid)!, firstName: firstName, lastName: lastName, email: email)
                    
                    do {
                        let _ = try self.db.collection("users").addDocument(from: newUser)
                    } catch {
                        self.showError("error storing user")
                    }
                    self.resetFields()
                    self.performSegue(withIdentifier: "registerSuccess", sender: nil)
                }
            })
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
