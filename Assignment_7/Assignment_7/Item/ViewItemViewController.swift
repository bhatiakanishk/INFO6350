//
//  ViewItemViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/5/22.
//

import UIKit

class ViewItemViewController: UIViewController {
    
    var mainVC: MainViewController?
    var outputStr = ""
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewItem()
    }
    
    
    func viewItem() {
        guard let mainVC = self.mainVC else { return }
        for item in mainVC.items {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No items exist" : outputStr
    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
