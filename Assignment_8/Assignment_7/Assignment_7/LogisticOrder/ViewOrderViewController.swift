//
//  ViewOrderViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class ViewOrderViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var outputStr = ""
    var mainVC: MainViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOrder()
        // Do any additional setup after loading the view.
    }
    
    func viewOrder() {
        guard let mainVC = self.mainVC else { return }
        for item in mainVC.logisticsOrder {
            outputStr.append(item.getDescription())
            outputStr.append("\n")
        }
        textView.text = outputStr.isEmpty ? "No orders exist" : outputStr
    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
}
