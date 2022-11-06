//
//  LocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/4/22.
//

import UIKit

class LocationViewController: UIViewController {
    var mainVC: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
}
