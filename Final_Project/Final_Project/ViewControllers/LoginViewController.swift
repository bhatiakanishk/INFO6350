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
    
    func validateFields() -> String {
        if Utilities.sanitizeTextInput(emailTf.text!) == "" ||
            Utilities.sanitizeTextInput(passwordTf.text!) == "" {
            return "Please fill in all fields."
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
