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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
