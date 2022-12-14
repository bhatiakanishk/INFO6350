//
//  LoginViewController.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/13/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTf.delegate = self
        passwordTf.delegate = self
        
        setupElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        clearError()
        resetFields()
    }
    
    func resetFields() {
        emailTf.text = ""
        passwordTf.text = ""
    }
    
    func clearError() {
        errorLabel.text = "error"
        errorLabel.alpha = 0
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setupElements() {
        clearError()
        
        emailTf.text = ""
        passwordTf.text = ""
    }
    
    func validateFields() -> String? {
        if Utilities.textInput(emailTf.text!) == "" ||
            Utilities.textInput(passwordTf.text!) == "" {
            return "Please enter all fields"
        }
        let emailTf = Utilities.textInput(emailTf.text!)
        
        if Utilities.emailValid(emailTf) == false {
            return "Invalid email address"
        }
        return nil
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

    @IBAction func loginBtn(_ sender: Any) {
        clearError()
        
        loginButton.isEnabled = false
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            let email = Utilities.textInput(emailTf.text!)
            let password = Utilities.textInput(passwordTf.text!)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    switch AuthErrorCode(rawValue: error!._code) {
                    case .userNotFound:
                        self.showError("User not registered")
                    case .networkError:
                        self.showError("Internet not connected")
                    case .invalidCredential, .invalidEmail, .wrongPassword:
                        self.showError("Invalid credentials")
                    default:
                        self.showError(error!.localizedDescription)
                    }
                } else {
                    self.resetFields()
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                }
            }
        }
        self.loginButton.isEnabled = true
    }
    
    func goToDashboard() {
        let userPostViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.userPostsViewController) as? UserPostsTableViewController
        navigationController?.pushViewController(userPostViewController, animated: true)
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
