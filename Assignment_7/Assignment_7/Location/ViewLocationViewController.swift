//
//  ViewLocationViewController.swift
//  Assignment_7
//
//  Created by Raj Kalpesh Mehta on 11/6/22.
//

import UIKit

class ViewLocationViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var mainVC: MainViewController?
    var outputStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLocation()
        // Do any additional setup after loading the view.
    }
    
    func viewLocation() {
        guard let mainVC = self.mainVC else { return }
        for item in mainVC.locations {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No locations exist" : outputStr
    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
